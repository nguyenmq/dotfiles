settings.smoothScroll = false;
settings.tabsMRUOrder = false;
settings.tabsThreshold = 0;
settings.stealFocusOnLoad = true;
settings.showModeStatus = false;
settings.richHintsForKeystroke = false;
settings.modeAfterYank = 'Normal';

// new mappings
api.mapkey('p', 'Switch frames', 'Normal.rotateFrame()');
api.mapkey('s', '#2Scroll down', 'Normal.scroll("down")', {repeatIgnore: true});
api.mapkey('w', '#2Scroll up', 'Normal.scroll("up")', {repeatIgnore: true});
api.mapkey('gu', '#4Edit current URL with vim editor', function() {
    api.Front.showEditor(window.location.href, function(data) {
        RUNTIME("openLink", { tab: { tabbed: false }, url: data } );
    }, 'url');
});
api.mapkey('gU', '#4Edit current URL with vim editor', function() {
    api.Front.showEditor(window.location.href, function(data) {
        tabOpenLink(data);
    }, 'url');
});

// unmaps
api.unmap('C');
api.unmap('ss');
api.unmap('k', /(reddit|feedly|mail\.google)\.com/);
api.unmap('j', /(reddit|feedly|mail\.google)\.com/);
api.unmap('v', /feedly\.com/);
api.unmap('p', /reddit\.com/);
api.unmap('m', /reddit\.com/);
api.unmap('M', /reddit\.com/);
api.unmap('n', /reddit\.com/);
api.iunmap(':');

// alias current mappings
api.map('F', 'af');
api.map('s', 'j');
api.map('w', 'k');
api.map(';m', 'sm');

// link hint color
api.Hints.style('border: solid 1px #000000; color:#000000; background: initial; background-color: #fbff6f; font-family: "Ubuntu";');

// omnibar theme
settings.theme = `
.sk_theme {
    background: #ffffff;
    color: #000000;
}

.sk_theme tbody {
    color: #ffffff;
}

.sk_theme input {
    color: #000000;
}

.sk_theme .url {
    color: #2bb24c;
}

.sk_theme .annotation {
    color: #000000;
}

.sk_theme .focused {
    background: #c7c7c7;
}

#sk_status {
    right: 89% !important;
    font-size: 14px !important;
}
`
