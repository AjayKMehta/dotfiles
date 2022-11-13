# sample ipython_config.py
#c = get_config()

c.TerminalIPythonApp.display_banner = True
c.TerminalIPythonApp.log_level = 'WARN'
c.TerminalIPythonApp.reraise_ipython_extension_failures = True

c.InteractiveShellApp.pylab = 'auto'

c.TerminalInteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.confirm_exit = False
c.TerminalInteractiveShell.debug = True
c.TerminalInteractiveShell.logappend = 'c:/temp/ipython.log'
c.TerminalInteractiveShell.xmode = 'Context'
c.TerminalInteractiveShell.highlighting_style = 'monokai'
c.TerminalInteractiveShell.logstart = True

c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']

c.PrefilterManager.multi_line_specials = True

# c.InteractiveShellApp.gui = 'asyncio'
# c.InteractiveShellApp.matplotlib = 'agg'

c.Application.log_level = 'WARN'
