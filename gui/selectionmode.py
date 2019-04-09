import pdb
import gui.mode
import math
from lib.stroke import Stroke
from gettext import gettext as _


# TODO: SelectionMode is not implemented
class SelectionMode (gui.mode.InteractionMode):
    ACTION_NAME = "SelectionMode"

    def __init__(self):
        self.selection_rect = (0, 0, 0, 0)
        self.cache = False

    @classmethod
    def get_name(cls):
        return _(u"Rectangular Selection.")

    def get_usage(self):
        return _(u"do rectangular selection magic")

    def enter(self, doc, **kwds):
        super(SelectionMode, self).enter(doc, **kwds)
        print("Entering the Selection mode")
        if not self.cache:
            self.cache = True
            self._snowflake(0, 0, 7, 200, 2)

    def leave(self):
        super(SelectionMode, self).leave()
        print("Leaving the Selection mode")

    def _stroke_line(self, x1, y1, x2, y2):
        dx = x2 - x1
        dy = y2 - y1
        l = math.sqrt(dx * dx + dy * dy)
        dx /= l
        dy /= l

        stroke = Stroke()
        stroke.start_recording(self.doc.model.brush)
        while (abs(x1 - x2) > 1e-3) or (abs(y1 - y2) > 1e-3):
            # print(x1, x2)
            stroke.record_event(0.008, x1, y1, 0.5, 0.0, 0.0, 1.0, 0.0, 0.0)
            x1 += dx
            y1 += dy
        stroke.stop_recording()

        self.doc.model.layer_stack.current.render_stroke(stroke)

    def _snowflake(self,
                   center_x, center_y,
                   branch_count, branch_length,
                   level):
        if level <= 0:
            return

        alpha = 2 * math.pi / branch_count

        for i in xrange(branch_count):
            center_x0 = center_x + branch_length * math.cos(alpha * i)
            center_y0 = center_y + branch_length * math.sin(alpha * i)
            self._stroke_line(center_x, center_y,
                              center_x0, center_y0)
            self._snowflake(center_x0, center_y0,
                            branch_count,
                            branch_length * 0.30,
                            level - 1)
