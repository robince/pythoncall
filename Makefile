
# MEX=mex
# explicit path because tex interferes on my mac
MEX=/Applications/MATLAB_R2009a.app/bin/mex
# only needed on a mac
MACLDFLAGS=-undefined dynamic_lookup -bundle


# nb http://bugs.python.org/issue7541
# on a mac need to 
# ln -s libpython2.5.a libpython2.5.dylib
PYLDFLAGS=`python-config --ldflags`
PYINCLUDE=`python-config --includes`
NPYINCLUDE=`python -c "import numpy.distutils; print numpy.distutils.misc_util.get_numpy_include_dirs()[0]"`

NUMPYINC=/Library/Frameworks/Python.framework/Versions/2.5/lib/python2.5/site-packages/numpy/core/include

all: pythoncall.mexglx

pythoncall.mexglx: pythoncall.c
	${MEX} -v CFLAGS='-DNUMPY -DNO_DLFCN_HACK ${PYINCLUDE} -I${NPYINCLUDE}' $^ LDFLAGS='${PYLDFLAGS} ${MACLDFLAGS}'

clean:
	rm -f pythoncall.o pythoncall.mexglx
