/**
 * Copyright (c) 2016 by Ludwig Grill (www.rotzbua.de)
 * Throws error if c++11 is not supported
 */
#ifndef REQUIRE_CPP11_H
#define REQUIRE_CPP11_H

#if __cplusplus < 201703L
#error "This library needs at least a C++17 compliant compiler, maybe compiler argument for C++17 support is missing."
#endif

#endif // REQUIRE_CPP11_H
