import asyncio
from typing import Optional

from flet.controls.alignment import Alignment
from flet.controls.base_control import control
from flet.controls.constrained_control import ConstrainedControl
from flet.controls.control import Control
from flet.controls.control_event import EventHandler
from flet.controls.duration import DurationValue
from flet.controls.events import (
    ScaleEndEvent,
    ScaleStartEvent,
    ScaleUpdateEvent,
)
from flet.controls.margin import MarginValue
from flet.controls.types import ClipBehavior, Number

__all__ = ["InteractiveViewer"]


@control("InteractiveViewer")
class InteractiveViewer(ConstrainedControl):
    """
    Allows you to pan, zoom, and rotate its [`content`][(c).].

    Raises:
        AssertionError: If [`content`][(c).] is not visible.
        AssertionError: If [`min_scale`][(c).] is not greater than `0`.
        AssertionError: If [`max_scale`][(c).] is not greater than `0`.
        AssertionError: If [`max_scale`][(c).] is less than `min_scale`.
        AssertionError: If [`interaction_end_friction_coefficient`][(c).] is not greater than `0`.
    """

    content: Control
    """
    The `Control` to be transformed.
    """

    pan_enabled: bool = True
    """
    Whether panning is enabled.
    """

    scale_enabled: bool = True
    """
    Whether scaling is enabled.
    """

    trackpad_scroll_causes_scale: bool = False
    """
    Whether scrolling up/down on a trackpad should cause scaling instead of panning.
    """

    constrained: bool = True
    """
    Whether the normal size constraints at this point in the widget tree are applied
    to the child.
    """

    max_scale: Number = 2.5
    """
    The maximum allowed scale.

    Note:
        Must be greater than or equal to [`min_scale`][flet.InteractiveViewer.min_scale].
    """

    min_scale: Number = 0.8
    """
    The minimum allowed scale.

    Note:
        Must be greater than `0` and less than or equal to [`max_scale`][flet.InteractiveViewer.max_scale].
    """

    interaction_end_friction_coefficient: Number = 0.0000135
    """
    Changes the deceleration behavior after a gesture.

    Note:
        Must be greater than `0`.
    """

    scale_factor: Number = 200
    """
    The amount of scale to be performed per pointer scroll.
    """

    clip_behavior: ClipBehavior = ClipBehavior.HARD_EDGE
    """
    How to clip the `content`.
    """

    alignment: Optional[Alignment] = None
    """
    Alignment of the `content` within.
    """

    boundary_margin: MarginValue = 0
    """
    A margin for the visible boundaries of the `content`.
    """

    interaction_update_interval: int = 200
    """
    The interval (in milliseconds) at which the `on_interaction_update` event is fired.
    """

    on_interaction_start: Optional[
        EventHandler[ScaleStartEvent["InteractiveViewer"]]
    ] = None
    """
    Called when the user begins a pan or scale gesture.
    """

    on_interaction_update: Optional[
        EventHandler[ScaleUpdateEvent["InteractiveViewer"]]
    ] = None
    """
    Called when the user updates a pan or scale gesture.
    """

    on_interaction_end: Optional[EventHandler[ScaleEndEvent["InteractiveViewer"]]] = (
        None
    )
    """
    Called when the user ends a pan or scale gesture.
    """

    def before_update(self):
        super().before_update()
        assert self.content.visible, "content must be visible"
        assert self.min_scale > 0, (
            f"min_scale must be greater than 0, got {self.min_scale}"
        )
        assert self.max_scale > 0, (
            f"max_scale must be greater than 0, got {self.max_scale}"
        )
        assert self.max_scale >= self.min_scale, (
            f"max_scale must be greater than or equal to min_scale, got max_scale={self.max_scale}, min_scale={self.min_scale}"
        )
        assert (
            self.interaction_end_friction_coefficient is None
            or self.interaction_end_friction_coefficient > 0
        ), (
            f"interaction_end_friction_coefficient must be greater than 0, got {self.interaction_end_friction_coefficient}"
        )

    def reset(self, animation_duration: Optional[DurationValue] = None):
        asyncio.create_task(self.reset_async(animation_duration))

    async def reset_async(self, animation_duration: Optional[DurationValue] = None):
        await self._invoke_method_async(
            "reset", arguments={"animation_duration": animation_duration}
        )

    def save_state(self):
        asyncio.create_task(self.save_state_async())

    async def save_state_async(self):
        await self._invoke_method_async("save_state")

    def restore_state(self):
        asyncio.create_task(self.restore_state_async())

    async def restore_state_async(self):
        await self._invoke_method_async("restore_state")

    def zoom(self, factor: Number):
        asyncio.create_task(self.zoom_async(factor))

    async def zoom_async(self, factor: Number):
        await self._invoke_method_async("zoom", arguments={"factor": factor})

    def pan(self, dx: Number, dy: Number = 0, dz: Number = 0):
        asyncio.create_task(self.pan_async(dx, dy, dz))

    async def pan_async(self, dx: Number, dy: Number = 0, dz: Number = 0):
        await self._invoke_method_async("pan", arguments={"dx": dx, "dy": dy, "dz": dz})
