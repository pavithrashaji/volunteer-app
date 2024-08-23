from django.shortcuts import render
from rest_framework import generics
from rest_framework.filters import SearchFilter
from rest_framework.response import Response
from rest_framework.exceptions import NotFound
from .models import User, Opportunity, Organisation, Application
from .serializers import UserSerializer, UserStatSerializer, OpportunitySerializer, ApplicationGetSerializer, ApplicationPostSerializer, OrganisationSerializer

import logging
import joblib
import json
import numpy as np

logger = logging.getLogger(__name__)

# Create your views here.
class UserCreateView(generics.ListCreateAPIView):
	queryset = User.objects.all()
	serializer_class = UserSerializer

class UserLoginView(generics.RetrieveAPIView):
	serializer_class = UserSerializer
	queryset = User.objects.all()

	def get_object(self):
		email = self.request.query_params.get('email', None)
		if email is None:
			raise NotFound(detail="Email not provided.")
		try:
			user = self.queryset.get(email=email)
		except User.DoesNotExist:
			raise NotFound(detail="User not found.")
		return user
	
class UserDisplayView(generics.RetrieveUpdateDestroyAPIView):
	queryset = User.objects.all()
	serializer_class = UserStatSerializer

class OppRetrieveView(generics.ListAPIView):
	serializer_class = OpportunitySerializer

	def get_queryset(self):
		companyid = self.request.query_params.get('companyid', None)
		if companyid is None:
			raise NotFound(detail="Company ID not provided.")
		queryset = Opportunity.objects.filter(companyid=companyid)

		return queryset
	
class OpportunitySearchView(generics.ListAPIView):
	serializer_class = OpportunitySerializer
	filter_backends = (SearchFilter,)
	search_fields = ('title', 'description')

	def get_queryset(self):
		query = self.request.query_params.get('title', None)
		if query:
			return Opportunity.objects.filter(title__icontains=query)
		return Opportunity.objects.all()
	
	def list(self, request, *args, **kwargs):
		queryset = self.get_queryset()
		serializer = OpportunitySerializer(queryset, many=True)
		ids = [opportunity['id'] for opportunity in serializer.data]
		return Response(ids)

class OpportunityCreateView(generics.ListCreateAPIView):
	queryset = Opportunity.objects.all()
	serializer_class = OpportunitySerializer

	def post(self, request, *args, **kwargs):
		sdg_data = [
			'No Poverty',
			'Zero Hunger',
			'Good Health and Well-being',
			'Quality Education',
			'Gender Equality',
			'Clean Water and Sanitation',
			'Affordable and Clean Energy',
			'Decent Work and Economic Growth',
			'Industry, Innovation, and Infrastructure',
			'Reduced Inequality',
			'Sustainable Cities and Communities',
			'Responsible Consumption and Production',
			'Climate Action',
			'Life Below Water',
			'Life on Land',
			'Peace, Justice, and Strong Institutions',
			'Partnerships for the Goals'
    	]
		decoded_request = request.data
		print(decoded_request)
		clf = joblib.load('model.pkl')
		count_vect = joblib.load('count_vect.pkl')
		preds = clf.predict_proba(count_vect.transform([decoded_request.get('title') + " " + decoded_request.get('description')]))
		preds_idx = np.argsort(preds, axis=1)[0][-2:]
		print(preds_idx)
		request.data['sdgoal1'] = sdg_data[preds_idx[1]]
		request.data['sdgoal2'] = sdg_data[preds_idx[0]]
		return self.create(request, *args, **kwargs)

class OpportunityDisplayView(generics.RetrieveUpdateDestroyAPIView):
	queryset = Opportunity.objects.all()
	serializer_class = OpportunitySerializer

class ApplicationDisplayView(generics.RetrieveUpdateDestroyAPIView):
	queryset = Application.objects.all()
	serializer_class = ApplicationGetSerializer

class ApplicationListCreateView(generics.ListCreateAPIView):
	queryset = Application.objects.all()
	#serializer_class = ApplicationPostSerializer
	def get_serializer_class(self):
		if(self.request.method == "GET"):
			return ApplicationGetSerializer
		else:
			return ApplicationPostSerializer
		
class ApplicationRetrieveUserView(generics.ListAPIView):
	serializer_class = ApplicationGetSerializer

	def get_queryset(self):
		user = self.request.query_params.get('user', None)
		if user is None:
			raise NotFound(detail="User ID not provided.")
		
		applications = Application.objects.filter(user=user)
		if not applications.exists():
			raise NotFound(detail="Applications not found.")
		return applications
	
class ApplicationRetrieveOppView(generics.ListAPIView):
	serializer_class = ApplicationGetSerializer

	def get_queryset(self):
		opportunity = self.request.query_params.get('opportunity', None)
		if opportunity is None:
			raise NotFound(detail="Opportunity ID not provided.")
		applications = Application.objects.filter(opportunity=opportunity)
		if not applications.exists():
			raise NotFound(detail="Applications not found.")
		return applications

class OrganisationCreateView(generics.ListCreateAPIView):
	queryset = Organisation.objects.all()
	serializer_class = OrganisationSerializer

class OrganisationDisplayView(generics.RetrieveUpdateDestroyAPIView):
	queryset = Organisation.objects.all()
	serializer_class = OrganisationSerializer

class OrganisationLoginView(generics.RetrieveAPIView):
        serializer_class = OrganisationSerializer
        queryset = Organisation.objects.all()
        
        def get_object(self):
                email = self.request.query_params.get('email', None)
                if email is None:
                        raise NotFound(detail="Email not provided.")
                try:    
                        organisation = self.queryset.get(email=email)
                except Organisation.DoesNotExist:   
                        raise NotFound(detail="Organisation not found.")
                return organisation
