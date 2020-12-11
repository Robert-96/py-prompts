import sys


class VersionPromptPS1(object):

    def __str__(self):
        return "[Py %d.%d] >>> " % (sys.version_info.major, sys.version_info.minor)

    def __len__(self):
        return len(str(self))


class VersionPromptPS2(object):

    def __str__(self):
        width = len(sys.ps1)
        return "... ".rjust(width, " ")


sys.ps1 = VersionPromptPS1()
sys.ps2 = VersionPromptPS2()
