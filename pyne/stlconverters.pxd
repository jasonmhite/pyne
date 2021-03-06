# Cython imports
from libcpp.utility cimport pair
from libcpp.map cimport map as cpp_map
from libcpp.set cimport set as cpp_set
from libcpp.vector cimport vector as cpp_vector
from cython.operator cimport dereference as deref
from cython.operator cimport preincrement as inc

# Python Imports
#cimport collections
import collections

cimport numpy as np
import numpy as np

# Local imports
include "include/cython_version.pxi"
IF CYTHON_VERSION_MAJOR == 0 and CYTHON_VERSION_MINOR >= 17:
    from libcpp.string cimport string as std_string
ELSE:
    from pyne._includes.libcpp.string cimport string as std_string
cimport extra_types


#
# Map conversions
#

# <int, int> conversions
cdef cpp_map[int, int] dict_to_map_int_int(dict)
cdef dict map_to_dict_int_int(cpp_map[int, int])

# <int, double> conversions
cdef cpp_map[int, double] dict_to_map_int_dbl(dict)
cdef dict map_to_dict_int_dbl(cpp_map[int, double])

# <string, int> conversions
cdef cpp_map[std_string, int] dict_to_map_str_int(dict)
cdef dict map_to_dict_str_int(cpp_map[std_string, int])

# <int, string> conversions
cdef cpp_map[int, std_string] dict_to_map_int_str(dict)
cdef dict map_to_dict_int_str(cpp_map[int, std_string])

# <string, double> conversions
cdef cpp_map[std_string, double] dict_to_map_str_dbl(dict)
cdef dict map_to_dict_str_dbl(cpp_map[std_string, double])


#
# Set conversions
#

# Integer sets
cdef cpp_set[int] py_to_cpp_set_int(set)
cdef set cpp_to_py_set_int(cpp_set[int])

# String sets
cdef cpp_set[std_string] py_to_cpp_set_str(set)
cdef set cpp_to_py_set_str(cpp_set[std_string])


#
# Vector conversions
#

# 1D Float arrays
cdef cpp_vector[double] array_to_vector_1d_dbl(np.ndarray[np.float64_t, ndim=1])
cdef np.ndarray[np.float64_t, ndim=1] vector_to_array_1d_dbl(cpp_vector[double])


# 1D Integer arrays
cdef cpp_vector[int] array_to_vector_1d_int(np.ndarray[np.int32_t, ndim=1])
cdef np.ndarray[np.int32_t, ndim=1] vector_to_array_1d_int(cpp_vector[int])


# 2D Float arrays
cdef cpp_vector[cpp_vector[double]] array_to_vector_2d_dbl(np.ndarray[np.float64_t, ndim=2])
cdef np.ndarray[np.float64_t, ndim=2] vector_to_array_2d_dbl(cpp_vector[cpp_vector[double]])


# 3D Float arrays
cdef cpp_vector[cpp_vector[cpp_vector[double]]] array_to_vector_3d_dbl(np.ndarray[np.float64_t, ndim=3])
cdef np.ndarray[np.float64_t, ndim=3] vector_to_array_3d_dbl(cpp_vector[cpp_vector[cpp_vector[double]]])



#
# Map-Vector Conversions
#

# {int: np.array()} 
cdef cpp_map[int, cpp_vector[double]] dict_to_map_int_array_to_vector_1d_dbl(dict)
cdef dict map_to_dict_int_vector_to_array_1d_dbl(cpp_map[int, cpp_vector[double]])

cdef cpp_map[int, cpp_vector[cpp_vector[double]]] dict_to_map_int_array_to_vector_2d_dbl(dict)
cdef dict map_to_dict_int_vector_to_array_2d_dbl(cpp_map[int, cpp_vector[cpp_vector[double]]])

cdef cpp_map[int, cpp_vector[cpp_vector[cpp_vector[double]]]] dict_to_map_int_array_to_vector_3d_dbl(dict)
cdef dict map_to_dict_int_vector_to_array_3d_dbl(cpp_map[int, cpp_vector[cpp_vector[cpp_vector[double]]]])

# {string: np.array()} 
cdef cpp_map[std_string, cpp_vector[double]] dict_to_map_str_array_to_vector_1d_dbl(dict)
cdef dict map_to_dict_str_vector_to_array_1d_dbl(cpp_map[std_string, cpp_vector[double]])


#
# Map-Map-Vector Conversions
#


# {int: {int: np.array()}}
cdef cpp_map[int, cpp_map[int, cpp_vector[double]]] dict_to_map_int_int_array_to_vector_1d_dbl(dict)
cdef dict map_to_dict_int_int_vector_to_array_1d_dbl(cpp_map[int, cpp_map[int, cpp_vector[double]]])


#
# Proxy Classes
#

# These classes have to be declared individually
# because Cython does not yet support templating 
# metaprogramming.

#
# --- Sets
#

# Int
cdef class SetIterInt(object):
    cdef cpp_set[int].iterator * iter_now
    cdef cpp_set[int].iterator * iter_end
    cdef void init(SetIterInt, cpp_set[int] *)

cdef class _SetInt:
    cdef cpp_set[int] * set_ptr
    cdef public bint _free_set


# Str
cdef class SetIterStr(object):
    cdef cpp_set[std_string].iterator * iter_now
    cdef cpp_set[std_string].iterator * iter_end
    cdef void init(SetIterStr, cpp_set[std_string] *)

cdef class _SetStr:
    cdef cpp_set[std_string] * set_ptr
    cdef public bint _free_set


#
# --- Maps
#

# (Str, Int)
cdef class MapIterStrInt(object):
    cdef cpp_map[std_string, int].iterator * iter_now
    cdef cpp_map[std_string, int].iterator * iter_end
    cdef void init(MapIterStrInt, cpp_map[std_string, int] *)

cdef class _MapStrInt:
    cdef cpp_map[std_string, int] * map_ptr
    cdef public bint _free_map


# (Int, Str)
cdef class MapIterIntStr(object):
    cdef cpp_map[int, std_string].iterator * iter_now
    cdef cpp_map[int, std_string].iterator * iter_end
    cdef void init(MapIterIntStr, cpp_map[int, std_string] *)

cdef class _MapIntStr:
    cdef cpp_map[int, std_string] * map_ptr
    cdef public bint _free_map


# (Str, Double)
cdef class MapIterStrDouble(object):
    cdef cpp_map[std_string, double].iterator * iter_now
    cdef cpp_map[std_string, double].iterator * iter_end
    cdef void init(MapIterStrDouble, cpp_map[std_string, double] *)

cdef class _MapStrDouble:
    cdef cpp_map[std_string, double] * map_ptr
    cdef public bint _free_map


# (Int, Int)
cdef class MapIterIntInt(object):
    cdef cpp_map[int, int].iterator * iter_now
    cdef cpp_map[int, int].iterator * iter_end
    cdef void init(MapIterIntInt, cpp_map[int, int] *)

cdef class _MapIntInt:
    cdef cpp_map[int, int] * map_ptr
    cdef public bint _free_map


# (Int, Double)
cdef class MapIterIntDouble(object):
    cdef cpp_map[int, double].iterator * iter_now
    cdef cpp_map[int, double].iterator * iter_end
    cdef void init(MapIterIntDouble, cpp_map[int, double] *)

cdef class _MapIntDouble:
    cdef cpp_map[int, double] * map_ptr
    cdef public bint _free_map


# (Int, Complex)
cdef class MapIterIntComplex(object):
    cdef cpp_map[int, extra_types.complex_t].iterator * iter_now
    cdef cpp_map[int, extra_types.complex_t].iterator * iter_end
    cdef void init(MapIterIntComplex, cpp_map[int, extra_types.complex_t] *)

cdef class _MapIntComplex:
    cdef cpp_map[int, extra_types.complex_t] * map_ptr
    cdef public bint _free_map

