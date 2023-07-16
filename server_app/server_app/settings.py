from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-mu86+57^-)6l=cgq8+0&&h82u@@9ss%n1dv_#=u(_v$62u#@ab'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ["*"]

# Application definition

INSTALLED_APPS = [

    'jazzmin',
    'csvexport',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'wkhtmltopdf',
    # Custom Applications
    'api.apps.ApiConfig',
    'cusine_app.apps.CusineAppConfig',
    'dish_app.apps.DishAppConfig',
    'order_app.apps.OrderAppConfig',
    'paymentmode_app.apps.PaymentmodeAppConfig',
    'report_app.apps.ReportAppConfig',
    'table_app.apps.TableAppConfig',
    'authentication.apps.AuthenticationConfig',

    # Api Apps
    'rest_framework',
    'rest_framework.authtoken',
    'djoser',
]

WKHTMLTOPDF_CMD = 'C:/Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe'
WKHTMLTOPDF_CMD_OPTIONS = {
    'page-width': '140mm',
    'page-height': '180mm',
    'margin-top': '2mm',
    'margin-right': '2mm',
    'margin-bottom': '2mm',
    'margin-left': '2mm',
}



REST_FRAMEWORK = {

    'DEFAULT_AUTHENTICATION_CLASSES' : [
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication'
    ],

    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated'
    ]
}


DJOSER = {
    'LOGIN_FIELD': 'email',
    'SERIALIZERS': {
        'user': 'authentication.serializers.CustomUserSerializer',
        'current_user': 'authentication.serializers.CustomUserSerializer',
    },
}

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'server_app.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(BASE_DIR, 'templates')
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'server_app.wsgi.application'

# JAZZMIN CONFIGURATION
JAZZMIN_SETTINGS = {
    "site_title": "TasteMe | Server Administration Site",

    "site_header": "TasteMe | Server Administration Site",

    "site_brand": "Site Control Panel",

    # Logo to use for your site, must be present in static files, used for brand on top left
    # "site_logo": "books/img/logo.png",

    "login_logo": None,
    "login_logo_dark": None,
    "site_logo_classes": "img-circle",
    "site_icon": None,

    # Welcome text on the login screen
    "welcome_sign": "An ordering system for graciella grillery and seafoods restaurant",
    "copyright": "TasteMe | Server Administration Site",
    "search_model": ["auth.User",],
    "user_avatar_icon": "fas fa-user-tie",
    # "user_avatar": "jazzmin/img/default.jpg",


    #############
    # Side Menu #
    #############

    "show_sidebar": True,
    "navigation_expanded": True,
    "order_with_respect_to": ["auth"],

    # Custom links to append to app groups, keyed on app name
    "custom_links": {
        "books": [{
            "name": "Make Messages", 
            "url": "make_messages", 
            "icon": "fas fa-comments",
            "permissions": ["books.view_book"]
        }]
    },


    "icons": {
        "auth": "fas fa-users-cog",
        "auth.user": "fas fa-user",
        "auth.Group": "fas fa-users",
        "authtoken.Token": "fas fa-id-card",
        "cusine_app.Cusine": "fas fa-sink",
        "paymentmode_app.Payment": "fas fa-money-check",
        "order_app.Order": "fas fa-list-ul",
        "order_app.CustomerOrder": "fas fa-user-tag",
        "feedback_app.FeedbackModel": "fas fa-user-edit",
        "settings.Currency": "fas fa-money-bill-wave-alt",
        "settings.Settings": "fas fa-building",
        "table_app.Table": "fas fa-utensils",
        "dish_app.DishType": "fas fa-tags",
        "dish_app.DishModel": "fas fa-hotdog",
    },

    "default_icon_parents": "fas fa-chevron-circle-right",
    "default_icon_children": "fas fa-id-card",

    #################
    # Related Modal #
    #################

    "related_modal_active": False,

    #############
    # UI Tweaks #
    #############
    "custom_css": None,
    "custom_js": None,
    "use_google_fonts_cdn": True,
    "show_ui_builder": True,

    ###############
    # Change view #
    ###############

    "changeform_format": "collapsible",
    "changeform_format_overrides": {"auth.user": "collapsible", "auth.group": "vertical_tabs"},
    "version": False,
}

# AUTH_USER_MODEL = 'authentication.CustomUserModel'

JAZZMIN_UI_TWEAKS = {
    "navbar_small_text": False,
    "footer_small_text": False,
    "body_small_text": False,
    "brand_small_text": False,
    "brand_colour": "navbar-white",
    "accent": "accent-navy",
    "navbar": "navbar-white navbar-light",
    "no_navbar_border": True,
    "navbar_fixed": True,
    "layout_boxed": False,
    "footer_fixed": True,
    "sidebar_fixed": False,
    "sidebar": "sidebar-light-navy",
    "sidebar_nav_small_text": False,
    "sidebar_disable_expand": False,
    "sidebar_nav_child_indent": False,
    "sidebar_nav_compact_style": False,
    "sidebar_nav_legacy_style": False,
    "sidebar_nav_flat_style": False,
    "theme": "default",
    "dark_mode_theme": None,
    "button_classes": {
        "primary": "btn-primary",
        "secondary": "btn-secondary",
        "info": "btn-info",
        "warning": "btn-warning",
        "danger": "btn-danger",
        "success": "btn-success"
    },
    "actions_sticky_top": True
}



# Database
# https://docs.djangoproject.com/en/4.2/ref/settings/#databases

DATABASES = {
    # 'default': {
    #     'ENGINE': 'django.db.backends.sqlite3',
    #     'NAME': BASE_DIR / 'db.sqlite3',
    # }

    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'tasteme_db',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1',
    }
}


# Password validation
# https://docs.djangoproject.com/en/4.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/4.2/topics/i18n/

# LANGUAGE_CODE = 'en-us'

# TIME_ZONE = 'UTC'

# USE_I18N = True

# USE_TZ = True


LANGUAGE_CODE = 'en-ph'
TIME_ZONE = 'Asia/Manila'
USE_I18N = False
USE_TZ = False


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/4.2/howto/static-files/

STATIC_URL = 'static/'
STATIC_ROOT = 'static/'

# Default primary key field type
# https://docs.djangoproject.com/en/4.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'
