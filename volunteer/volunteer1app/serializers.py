

from rest_framework import serializers
from .models import User, Opportunity, Organisation, Application
from django.db.models import Avg

class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = '__all__'

class OpportunitySerializer(serializers.ModelSerializer):
	class Meta:
		model = Opportunity
		fields = '__all__'

class ApplicationGetSerializer(serializers.ModelSerializer):
	user = UserSerializer(read_only=True)
	opportunity = OpportunitySerializer(read_only=True)
	
	class Meta:
		model = Application
		fields = '__all__'

class ApplicationPostSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Application
		fields = ['user','opportunity','status']
		extra_kwargs = {
			'opportunity': {'required': True},  
		}

class UserStatSerializer(serializers.ModelSerializer):
	completion_rate = serializers.SerializerMethodField()
	avg_rating = serializers.SerializerMethodField()

	def get_completion_rate(self,user):
		accepted = user.applications.all().exclude(completedStatus = 0).filter(status = 2)
		if accepted.count() == 0:
			return None
		completed = user.applications.all().filter(completedStatus = 1)
		return (completed.count()/accepted.count())*100
	
	def get_avg_rating(self,user):
		ratings = user.applications.all().filter(rating__isnull = False)
		if ratings.count() == 0:
			return None
		ratingval = ratings.aggregate(Avg('rating'))
		val = ratingval['rating__avg']
		return val
	
	class Meta:
		model = User
		fields = '__all__'

class OrganisationSerializer(serializers.ModelSerializer):
	class Meta:
		model = Organisation
		fields = '__all__'

