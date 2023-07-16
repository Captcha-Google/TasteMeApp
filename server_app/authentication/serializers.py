from djoser.serializers import UserSerializer
from django.contrib.auth import get_user_model

class CustomUserSerializer(UserSerializer):
    class Meta(UserSerializer.Meta):
        model = get_user_model()
        fields = ["id","username","first_name","last_name","email","is_staff","is_active","date_joined","last_login"]
