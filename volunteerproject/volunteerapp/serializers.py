from rest_framework import serializers
from .models import User, Organisation, Opportunity

class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = '__all__' 

class OrganisationSerializer(serializers.ModelSerializer):
	class Meta:
		model = Organisation
		fields = '__all__'

class OpportunitySerializer(serializers.ModelSerializer):
	class Meta:
		model = VolunteerOpportunity
		fields = '__all__'

