from jinja2.ext import Extension
import re


def email_from_author(author: str) -> str:
    """
    Converts an author's name into an email address.
    :param author: author's name
    :return: email
    ex {{ "Alpha B. Charlie" | email_from_author }} --> "abcharlie"
    """
    author_despaced = author.replace(' ', '')
    author_depunctuated = author_despaced.replace('.', '')
    email_address = re.sub(r'[a-z]*([A-Z])', '\\1', author_depunctuated)
    return email_address.lower()


def upper_case_first_letter(value):
    """
    Converts the first letter of a word to upper case, the remaining letters are as is.
    :param value: the value to be transformed.
    :return: transformed word.
    ex: {{ "ABc deF" | upper_case_first_letter }} should generate aBc deF
    """
    print(value)
    if len(value) > 1:
        return value[0].upper() + value[1:]
    elif len(value) == 1:
        return value[0].upper()
    else:
        return value


def slug(value):
    """
    Slugify (lower case, replace spaces with dashes) a given value.
    :param value: value to be slugified
    :return: slugified value
    ex: {{ "Abc deF" | slug }} should generate abc-def
    """
    return value.lower().replace(" ", "-")


class StringFilterExtension(Extension):
    def __init__(self, environment):
        super(StringFilterExtension, self).__init__(environment)

        environment.filters["email_from_author"] = email_from_author
        environment.filters["slug"] = slug
        environment.filters["upper_case_first_letter"] = upper_case_first_letter
