CXX = g++

all: main

main: main.o http_conn.o threadpool.o
	g++ $^ -o $@

clean:
	-rm main *.o

.PHONY: clean

sources = main.cc threadpool.cc http_conn.cc

include $(sources:.c=.d)

%.d: %.c
	set -e; rm -f $@; \
	$(CXX) -MM $(CXXFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.0 $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$