mkdocs (docker image)
=====================

Mkdocs including PythonMarkdown PlantUML extension.

This image will provide you mkdocs. Some examples of its usage:

Create a new project
--------------------

    docker run -it --rm -v `pwd`:/data docker.in-tech.global/mkdocs new my-project

Serve your project
------------------

If you are inside a VM (boot2docker or similar) you will need to set the host to `0.0.0.0`:

    cd my-project
    docker run --rm -v `pwd`:/data -p 8000:8000 docker.in-tech.global/mkdocs serve -a 0.0.0.0:8000

or just

    docker run --rm -v `pwd`:/data -p 8000:8000 docker.in-tech.global/mkdocs

Build your docs
---------------

    cd my-project
    docker run -it --rm -v `pwd`:/data docker.in-tech.global/mkdocs build

If you want to generate them in another place, mount `/data/site` as a volume:

    docker run -it --rm -v `pwd`:/data -v $HOME/Desktop/site:/data/site docker.in-tech.global/mkdocs build

PlantUML Usage
--------------

Inside your project file

    site_name: My Site Name
    markdown_extensions:
        - plantuml:
            outpath: "images"

See the following site for uml usage:
[https://github.com/mikitex70/plantuml-markdown](https://github.com/mikitex70/plantuml-markdown)
