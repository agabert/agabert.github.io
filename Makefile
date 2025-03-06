
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

upload:
	<"src/$(TEX)" ssh "$(REMOTE)" -- tee "/home/$(USER)/$(TEX)"

generate: upload
	$(RUN) texi2pdf "/home/$(USER)/$(TEX)" -o "/home/$(USER)/$(PDF)"

download: generate
	scp "$(REMOTE):/home/$(USER)/$(PDF)" "./$(PDF)"
	cp -v "$(PDF)" "$(HOME)/Downloads/$(PDF)"

