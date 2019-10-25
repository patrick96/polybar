 .. highlight:: ini

Getting Started
===============

This page is meant get you started with polybar and creating your own bar
configuration. Be sure to read this, if you are new to polybar as it introduces
the basics of polybar configuration.

Installation
------------

If possible, you should install polybar through your package manager. Check out
`Repology <https://repology.org/project/polybar/versions>`_ to see in which
repositories polybar is already available.

If you cannot find polybar already packaged for your distribution, you will need
to compile it yourself.
See our `Compiling <https://github.com/polybar/polybar/wiki/Compiling>`_ page
for detailed instructions.

Running Polybar
---------------

Now that you have successfully installed polybar you are all set to build your
first bar.

Polybar reads all bar configuration from a config file, usually located at
``~/.config/polybar/config``. The config file uses the INI file format, see
:doc:`man/polybar.5` or ``man 5 polybar`` for the exact syntax.

So let's go ahead and create that config file and write our first bar
configuration:

::

  [bar/mybar]
  modules-left = mytext

  [module/mytext]
  type = custom/text
  content = Text

This is the bare minimum needed to get the bar to display.
If you put this file into ``~/.config/polybar/config`` and run
``polybar mybar``, it should display a small black bar at the top of your
monitor with only the word ``Text`` on the left.

Let's break this down:

- ``[bar/mybar]`` defines a new section with the name ``bar/mybar``. It
  further defines a new bar with the name ``mybar`` because the section name
  starts with ``bar/``.

- ``modules-left = mytext`` assigns ``mytext`` to the key ``modules-left`` in the
  bar section. ``mytext`` refers to the module with the same name (more on that
  later). All modules ``modules-left`` will be displayed on the left side of the
  bar, there is also ``modules-center`` and ``modules-right``.

- ``[module/mytext]`` defines another section. This time it defines the section
  for the module named ``mytext`` because it starts with ``module/``.

- ``type = custom/text`` specifies the type of this module. Depending on the
  type, a module has a different behavior. The ``custom/text`` module is a very
  basic module that only displays some fixed text.

- ``content = Text`` is a property that is specific to the text module, it
  defines what text the module displays.

A Small Example
---------------

Alright, now that you know the basics, let's look at a small example that
actually does something (:download:`Download <_static/getting_started.conf>`):

.. literalinclude:: _static/getting_started.conf
   :language: dosini

If you put this file into ``~/.config/polybar/config`` and run ``polybar
mybar``, it should look a little like this:

.. figure:: _static/getting_started_config.png
   :target: _static/getting_started_config.png
   :align:   center

Nothing too fancy yet, but don't worry polybar can be customized more than
enough.

Fonts
-----

Next Steps
----------

Link to modules on wiki
