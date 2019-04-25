Configuration
=============

.. confval:: monitor

  :default: ``<empty string>``

  Specifies the monitor polybar should be displayed on.
  If unspecified the primary monitor is used.

  .. note::

    Either of the following commands will list the names of available monitors:

    .. code-block:: bash

      polybar -m | cut -d ':' -f 1
      xrandr -q | grep " connected" | cut -d ' ' -f1

