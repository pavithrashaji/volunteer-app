from django.contrib import admin
from .models import User, Opportunity, Organisation

# Register your models here.
admin.site.register(User)
admin.site.register(Opportunity)
admin.site.register(Organisation)
