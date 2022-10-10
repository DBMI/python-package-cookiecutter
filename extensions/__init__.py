from jinja2.ext import Environment
from .string_filters_extension import StringFilterExtension


environment: Environment = Environment(extensions=[StringFilterExtension])
