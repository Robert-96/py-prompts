import sys
from datetime import datetime


class DateTimePromptPS1(object):

    def __str__(self):
        return "[%s] >>> " % (datetime.now().strftime('%d/%m %H:%M'))

    def __len__(self):
        return len(str(self))


class DateTimePromptPS2(object):

    def __str__(self):
        width = len(sys.ps1)
        return "... ".rjust(width, " ")


sys.ps1 = DateTimePromptPS1()
sys.ps2 = DateTimePromptPS2()
