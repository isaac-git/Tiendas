#Makefile lorenmanu segundo hito
#clean install test run doc

clean:
	- rm -rf *~*
	- find . -name '*.pyc' -exec rm {} \;

install:
	pip install -r requirements.txt

test:
	python3 manage.py test

run:
	python3 manage.py runserver 0.0.0.0:80

doc:
	epydoc --html MiTienda/*.py
