import gui.mode
from gettext import gettext as _

# TODO: SelectionMode is not implemented
class SelectionMode (gui.mode.InteractionMode):
    ACTION_NAME = "SelectionMode"

    @classmethod
    def get_name(cls):
        return _(u"Rectangular Selection.")

    def get_usage(self):
        return _(u"do rectangular selection magic")

    def enter(self, doc, **kwds):
        super(SelectionMode, self).enter(doc, **kwds)
        print("Entering the Selection mode")
        print("From a new file")

    def leave(self):
        super(SelectionMode, self).leave()
        print("Leaving the Selection mode")
