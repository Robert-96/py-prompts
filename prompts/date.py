import sys
from datetime import datetime


class DatePromptPS1(object):

    def __str__(self):
        return "[%s] >>> " % (datetime.now().strftime('%d/%m'))

    def __len__(self):
        return len(str(self))


class DatePromptPS2(object):

    def __str__(self):
        width = len(sys.ps1)
        return "... ".rjust(width, " ")


sys.ps1 = DatePromptPS1()
sys.ps2 = DatePromptPS2()
