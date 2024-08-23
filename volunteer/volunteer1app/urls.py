from django.urls import path
from .views import (
	UserCreateView, 
	UserLoginView, 
	UserDisplayView, 
	OpportunityCreateView,
	OppRetrieveView, 
	OpportunityDisplayView,
    OpportunitySearchView,
	ApplicationListCreateView,
    ApplicationDisplayView,
    ApplicationRetrieveUserView,
    ApplicationRetrieveOppView,
	OrganisationCreateView,
	OrganisationLoginView, 
	OrganisationDisplayView
	)

urlpatterns = [
	path('users/', UserCreateView.as_view(), name='user-create'),
	path('users/<int:pk>/', UserDisplayView.as_view(), name='user-display'),
	path('users/by-email/', UserLoginView.as_view(), name='user-login'),

	path('opportunities/by-companyid/', OppRetrieveView.as_view(), name='opportunity-retrieve'),
	path('opportunities/', OpportunityCreateView.as_view(), name='opportunity-create'),
	path('opportunities/<int:pk>/', OpportunityDisplayView.as_view(), name='opportunity-display'),
	path('opportunities/search/', OpportunitySearchView.as_view(), name='opportunity-search'),

	path('applications/', ApplicationListCreateView.as_view(), name='application-create'),
    path('applications/<int:pk>/', ApplicationDisplayView.as_view(), name='application-display'),
    path('applications/by-user/', ApplicationRetrieveUserView.as_view(), name='application-retrieve-by-user'),
	path('applications/by-opportunity/', ApplicationRetrieveOppView.as_view(), name='application-retrieve-by-opportunity'),

	path('organisations/', OrganisationCreateView.as_view(), name='organisation-create'),
	path('organisations/<int:pk>/', OrganisationDisplayView.as_view(), name='organisation-display'),
	path('organisations/by-email/', OrganisationLoginView.as_view(), name='organisation-login'),
]
