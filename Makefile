
#
#    Copyright 2025 Alexander Gabert
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

include include/remote.mk

CHECKSUM = $(shell shasum src/resume2025.tex)

# from texinfo package, needs texlive package
all: download

RESUME = resume2025

TEX = $(RESUME).tex

PDF = $(RESUME).pdf

SRC = /home/$(USER)/src

upload:
	ssh "$(REMOTE)" -- mkdir -pv "$(SRC)/."
	rsync -HPavpx --delete-after src/. "$(REMOTE):$(SRC)/."

generate: upload
	$(RUN) 'cd $(SRC) && texi2pdf --shell-escape $(TEX) -o $(PDF)'

download: generate
	scp "$(REMOTE):$(SRC)/$(PDF)" "./$(PDF)"
	cp -v "$(PDF)" "$(HOME)/Downloads/$(PDF)"

