import sys
from datetime import datetime


class TimePromptPS1(object):

    def __str__(self):
        return "[%s] >>> " % (datetime.now().strftime('%H:%M'))

    def __len__(self):
        return len(str(self))


class TimePromptPS2(object):

    def __str__(self):
        width = len(sys.ps1)
        return "... ".rjust(width, " ")


sys.ps1 = TimePromptPS1()
sys.ps2 = TimePromptPS2()
