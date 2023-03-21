CXX = g++

all: main

main: threadpool.h
	g++ test.cpp

clean:
	-rm main *.o

.PHONY: clean

sources = main.cc threadpool.cc http_conn.cc

%.d: %.c
	set -e; rm -f $@; \
	$(CXX) -MM $(CXXFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.0 $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$