from cookiecutter.utils import simple_filter
import re


@simple_filter
def email_from_author(author, email_server = "ucsd.edu"):
    """
    Converts an author's name into an email address.
    :param author: author's name
           email_server: like "yahoo.com"
    :return: email
    ex {{ "Alpha B. Charlie" | email_from_author }} --> "abcharlie@ucsd.edu"
    ex {{ "Alpha B. Charlie" | email_from_author("gmail.com" }} --> "abcharlie@gmail.com"
    """
    author_despaced = author.replace(' ', '')
    author_depunctuated = author_despaced.replace('.', '')
    email_address = re.sub(r'[a-z]*([A-Z])', '\\1', author_depunctuated)
    return email_address.lower() + '@' + email_server
