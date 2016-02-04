#Makefile lorenmanu segundo hito
#clean install test run doc

clean:
	- rm -rf *~*
	- find . -name '*.pyc' -exec rm {} \;
	- find . -name '.DS_Store' -exec rm {} \;

install:
	python setup.py install

test:
	python manage.py test

run:
	python manage.py runserver
doc:
	epydoc --html MiTienda/*.py
