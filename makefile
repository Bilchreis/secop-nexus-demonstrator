



venv: frappy/._venv/touchfile .venv/touchfile 

.venv/touchfile: requirements.txt 
	python3 -m venv .venv
	. .venv/bin/activate; pip install --upgrade pip; pip install -r requirements.txt;cd nexuscreator/python_library ;pip install -e .
	touch .venv/touchfile


clean:  ## 🧹 Clean up project
	rm -rf .venv
	rm -rf frappy/._venv
	rm -rf tests/node_modules
	rm -rf tests/package*
	rm -rf test-results.xml
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf pids.txt
	rm -rf *_log.txt
	rm -rf *egg-info
	rm -rf build
	rm -rf dist
	rm -rf .env
	rm -rf genNodeClass.py


sim : venv 
	docker compose stop
	docker compose up --detach

stop: 
	docker compose down

rebuild:
	docker compose build --no-cache 


subinit: frappy/.gitignore


frappy/.gitignore:
	git submodule update --init

frappy_venv: frappy/._venv/touchfile

frappy/._venv/touchfile: subinit frappy/requirements-gui.txt 
	python3 -m venv frappy/._venv
	. frappy/._venv/bin/activate; pip install --upgrade pip; pip install -r frappy/requirements-gui.txt
	touch frappy/._venv/touchfile



frappy: sim subinit frappy_venv venv
	. frappy/._venv/bin/activate;(python3 frappy/bin/frappy-gui localhost:10800 localhost:10801 )