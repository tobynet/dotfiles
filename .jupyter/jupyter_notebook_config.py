# Put this file in `jupyter --paths`
import os
from subprocess import check_call

def post_save(model, os_path, contents_manager):
    if model['type'] != 'notebook':
        return

    # Save some formats
    d, fname = os.path.split(os_path)
    # .py
    check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)
    # .html
    check_call(['jupyter', 'nbconvert', '--to', 'html', fname], cwd=d)

c.FileContentsManager.post_save_hook = post_save
