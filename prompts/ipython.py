import sys


class IPythonPromptPS1(object):

    def __init__(self):
        self.line = 0

    def __str__(self):
        self.line += 1
        return "In [%d] >>> " % (self.line)

    def __len__(self):
        return len(str(self))


class IPythonPromptPS2(object):
    def __str__(self):
        width = len(sys.ps1)
        return "... ".rjust(width, " ")


sys.ps1 = IPythonPromptPS1()
sys.ps2 = IPythonPromptPS2()
