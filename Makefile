#Makefile lorenmanu segundo hito
#clean install test run doc

clean:
	- rm -rf *~*
	- find . -name '*.pyc' -exec rm {} \;
	- find . -name '.DS_Store' -exec rm {} \;

install:
	python setup.py install

database:
	python manage.py makemigrations
	python manage.py migrate	

test:
	python manage.py test

run:
	python manage.py runserver

doc:
	epydoc --html MiTienda/*.py
