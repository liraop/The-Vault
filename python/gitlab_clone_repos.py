# -*- coding: utf-8 -*-
"""GitLab API access and reposirory clone module.

To use this script you will need to have:
- python3
- python-gitlab library (installable via pip or clone)
- Personal Access Token with GitLab API permissions 

Example:
    $ python ./clone_repos.py YoUracceSSsToken

"""
import os
import sys

try:
    import gitlab
except:
    print("gitlab module not find. please install using pip install --upgrade python-gitlab")
    
def user_in_group(gitlab_connector,group_name):
    user_groups = gitlab_connector.groups.list()
    for group in user_groups:
        if group.name.lower() == group_name:
             return gitlab_connector.groups.get(group.id)
    return False

def get_subgroups(gitlab_connector, group):
    subgroups = []
    for subgroup in group.subgroups.list():
        mgmt_subgroup = gitlab_connector.groups.get(subgroup.id)
        subgroups.append(mgmt_subgroup)
    return subgroups

def get_available_repos(gitlab_connector, subgroups):
    repositories = {}
    index = 0
    for subgroup in subgroups:           
        for project in subgroup.projects.list():
            index = index + 1
            repositories[index] = project
    return repositories

def print_repo_list(repository_map):
    print("Available repositories:")
    for index,repo in repository_map.items():
        print(index, repo.name)

def get_repo_path(repository):
    namespace = repository.namespace["full_path"].split("/")
    path = " "
    for folder in namespace[1:]:
        path += folder
        path += "/"
    return path

def clone_repository(repository):
    repo_path = get_repo_path(repository)
    
    if not os.path.exists(repo_path):
        os.makedirs(repo_path)
    
    os.chdir(repo_path)
    os.system("git clone %s" % repository.http_url_to_repo)
    os.chdir("../..")


def get_repos_to_clone():
    try:
        indexes_to_clone = input("Yype in the repository number you wish to clone separated by spaces or blank to all. q to quit\n").split(" ") 
        return indexes_to_clone
    except:
        print("Please, just 2 3 4 5 6")   

def main(gitlab_url, token):
    gl = gitlab.Gitlab(gitlab_url, private_token=token)
    group_name = "web"
    groups = [user_in_group(gl, group_name)]
    subgroups = get_subgroups(gl, groups[0])
    
    if not groups:
        print("You are not member of %s. Please ask for permissions." % group_name ) 
    else:
        repositories = get_available_repos(gl, subgroups)
        print_repo_list(repositories)
        repos_to_clone = get_repos_to_clone()

        if len(repos_to_clone) == 1:
           for index,repo in repositories.items():            
                clone_repository(repo)
        else:      
            for index,repo in repositories.items():
                if index in repos_to_clone:
                    clone_repository(repo)

main(sys.argv[0], sys.argv[1])