
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

NOW = $(shell date +%s)

# from texinfo package, needs texlive package
all:
	sed 's,%%%LAST_UPDATED%%%,$(NOW),g;' resume2025.tex | \
		ssh $(REMOTE) -- tee /home/$(USER)/resume2025.tex
	$(RUN) texi2pdf /home/$(USER)/resume2025.tex -o /home/$(USER)/resume2025.pdf
	scp $(REMOTE):/home/$(USER)/resume2025.pdf .
	<index.html.template $(RUN) NOW=$(NOW) envsubst | tee index.html
