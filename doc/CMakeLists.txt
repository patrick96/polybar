set(SPHINX_FLAGS "" CACHE STRING "Flags to pass to sphinx-build")
separate_arguments(sphinx_flags UNIX_COMMAND "${SPHINX_FLAGS}")

option(BUILD_DOC_HTML "Build HTML documentation" ON)
option(BUILD_DOC_MAN "Build manpages" ON)

set(doc_path "${CMAKE_CURRENT_SOURCE_DIR}")

# Configures conf.py in the current folder and puts it in the build folder
configure_file(conf.py conf.py @ONLY)

# We want to run `sphinx-build` with the builders in doc_builders
set(doc_builders "")

if(BUILD_DOC_HTML)
  list(APPEND doc_builders "html")
endif()

if(BUILD_DOC_MAN)
  list(APPEND doc_builders "man")
endif()

# Name of all documentation targets
set(doc_targets "")

foreach(builder ${doc_builders})
  set(doc_target "doc_${builder}")
  set(builder_log "builder-${builder}.log")
  add_custom_target(${doc_target}
    COMMAND ${SPHINX_BUILD}
            -b ${builder}
            # conf.py dir
            -c "${CMAKE_CURRENT_BINARY_DIR}"
            -d "${CMAKE_CURRENT_BINARY_DIR}/doctrees"
            ${sphinx_flags}
            # Documentation source file dir
            "${CMAKE_CURRENT_SOURCE_DIR}"
            # Output dir
            "${CMAKE_CURRENT_BINARY_DIR}/${builder}" > ${builder_log}
    COMMENT "sphinx-build ${builder}: see doc/${builder_log}")

  list(APPEND doc_targets ${doc_target})
endforeach()

# Dummy target that depends on all documentation targets
add_custom_target(doc ALL DEPENDS ${doc_targets})

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html/
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
  COMPONENT doc)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/man/polybar.1
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man1
  COMPONENT doc)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/man/polybar.5
  DESTINATION ${CMAKE_INSTALL_MANDIR}/man5
  COMPONENT doc)
