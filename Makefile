.PHONY: all clean-data analyze setup
all: clean-data analyze
setup:
	python -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt
clean-data:
	python src/clean.py
analyze:
	python src/analyze.py
