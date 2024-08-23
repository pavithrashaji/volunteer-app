from django.db import models

# Create your models here.
class User(models.Model):
	name = models.CharField(max_length=100)
	email = models.EmailField(unique=True)
	postcode = models.CharField(max_length=8)
	contact_no = models.CharField(max_length=11, null=True, blank=True)
	password = models.CharField(max_length=30)
	university = models.CharField(max_length=40, null=True, blank=True)

	def __str__(self):
		return self.name

class Opportunity(models.Model):
	title = models.CharField(max_length = 100)
	company = models.CharField(max_length = 40)
	companyid = models.IntegerField(null=True, blank=True)
	duration = models.IntegerField(null=True, blank=True)
	description = models.TextField()
	sdgoal1 = models.CharField(max_length=100, null=True, blank=True)
	sdgoal2 = models.CharField(max_length=100, null=True, blank=True)
	start_date = models.DateField(null=True, blank=True)
	end_date = models.DateField(null=True, blank=True)

	def __str__(self):
		return self.title

class Application(models.Model):
	user = models.ForeignKey(User, on_delete=models.CASCADE, related_name = 'applications')
	opportunity = models.ForeignKey(Opportunity, on_delete=models.CASCADE)
	applied_at = models.DateTimeField(auto_now_add=True)
	status = models.IntegerField(default=0)
	completedStatus = models.IntegerField(default = 0)
	rating = models.IntegerField(null=True, blank=True)

	class Meta:
		unique_together = ('user', 'opportunity')

	def __str__(self):
		return f'{self.user.name} applied to {self.opportunity.title}'

class Organisation(models.Model):
	name = models.CharField(max_length=100)
	email = models.EmailField(unique=True)
	password = models.CharField(max_length=30)
	website = models.URLField(null=True, blank=True)
	description = models.TextField(null=True, blank=True)

	def __str__(self):
		return self.name
