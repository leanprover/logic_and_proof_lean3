SRCS = $(wildcard *.tex)
OBJS = $(patsubst %.tex,%.png,$(SRCS))

images : $(OBJS) clean

copy_images : images
	cp *.png ../_static/
	
%.png : %.pdf 
	convert -density 300 $< -quality 90 $@

%.pdf : %.tex
	pdflatex $<

clean :
	rm -f *.pdf *.log *.aux *.synctex.gz *.fls *.fdb_latexmk

clean_all : clean
	rm -f *.png