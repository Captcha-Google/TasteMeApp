from django import template

register = template.Library()

@register.filter
def divide_by_thousand(value):
    return int(value / 1000)