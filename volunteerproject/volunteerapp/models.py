from django.db import models

# Create your models here.
class User(models.Model):
	name = models.CharField(max_length=100)
	email = models.EmailField(unique=True)
	postcode = models.CharField(max_length=8)
	contact_no = models.CharField(max_length=11, null=True, blank=True)
	password = models.CharField(max_length=20)
	university = models.CharField(max_length=40, null=True, blank=True)
	def __str__(self):
		return self.name

class Opportunity(models.Model):
	title = models.CharField(max_length = 100)
	company = models.CharField(max_length = 40)
	start_date = models.DateField()
	end_date = models.DateField()
	description = models.TextField()
	def __str__(self):
		return self.title

class Organisation(models.Model):
	name = models.CharField(max_length=50)
	email = models.EmailField(unique=True)
	password = models.CharField(max_length=20)
	website = models.URLField(null=True, blank=True)
	description = models.TextField(null=True, blank=True)
	def __str__(self):
		return self.name
