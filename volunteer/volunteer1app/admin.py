from django.contrib import admin
from .models import User, Organisation, Opportunity, Application

# Register your models here.
admin.site.register(User)
admin.site.register(Opportunity)
admin.site.register(Organisation)
admin.site.register(Application)
