AC_PREREQ(2.52)

AC_INIT([Apertium English-Hindi], [0.1.0], [apertium-stuff@lists.sourceforge.net], [apertium-eng-hin], [https://wiki.apertium.org/wiki/Apertium-eng-hin])
AM_INIT_AUTOMAKE
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= 3.6.0)
PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox >= 3.5.0)
PKG_CHECK_MODULES(CG3, cg3 >= 1.3.0)
PKG_CHECK_MODULES(APERTIUM_LEX_TOOLS, apertium-lex-tools >= 0.2.2)

AP_CHECK_LING([2], [apertium-hin])

PKG_CHECK_MODULES(REGTEST, apertium-regtest >= 0.0.1, [],
                  [AC_MSG_WARN([Running tests requires apertium-regtest])])

AP_MKINCLUDE
AC_OUTPUT([Makefile])
