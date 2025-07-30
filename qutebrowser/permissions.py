#:set -u example.com content.images false.

# config.set('content.images', False, '*://example.com/')

with config.pattern("*://*.discord.com") as dc:
    dc.content.autoplay = True
#    dc.content.desktop_capture = True
#    dc.content.media.audio_capture = True
#    dc.content.media.audio_video_capture = True
#    dc.content.media.video_capture = True

with config.pattern("*://*.element.io") as el:
    el.content.autoplay = True
    el.content.desktop_capture = True
    el.content.media.audio_capture = True
    el.content.media.audio_video_capture = True
    el.content.media.video_capture = True
    el.content.notifications.enabled = True
    el.content.media.audio_capture = True

# with config.pattern("meet.element.io") as mel:
#    mel.content.desktop_capture = True
#    mel.content.media.audio_capture = True
#    mel.content.media.audio_video_capture = True
#    mel.content.media.video_capture = True
# with config.pattern("app.element.io") as el:
#    el.content.notifications.enabled = True
#    el.content.media.audio_capture = True

with config.pattern("*://mail.proton.me") as pm:
    pm.content.register_protocol_handler = True
    pm.content.notifications.enabled = True

with config.pattern("*://outlook.office.com") as outl:
    outl.content.register_protocol_handler = False
    outl.content.notifications.enabled = False

with config.pattern("*://skinport.com") as skport:
    skport.content.notifications.enabled = False

with config.pattern("*://mail.google.com") as gm:
    gm.content.register_protocol_handler = False
    gm.content.notifications.enabled = False

with config.pattern("*://*.aternos.org") as aternos:
    aternos.content.notifications.enabled = True
