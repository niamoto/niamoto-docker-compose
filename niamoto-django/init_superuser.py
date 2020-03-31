# coding: utf-8

from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

DEFAULT_ADMIN_USERNAME = "niamoto_admin"
DEFAULT_ADMIN_EMAIL = "tmangeard@gmx.fr"
DEFAULT_ADMIN_PASSWORD = "niamoto"

try:
    User.objects.get(username=DEFAULT_ADMIN_USERNAME)
except ObjectDoesNotExist:
    User.objects.create_superuser(
        DEFAULT_ADMIN_USERNAME,
        DEFAULT_ADMIN_EMAIL,
        DEFAULT_ADMIN_PASSWORD
    )
