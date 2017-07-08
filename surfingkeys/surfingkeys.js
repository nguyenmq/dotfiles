settings.smoothScroll = false;
settings.tabsMRUOrder = false;
settings.tabsThreshold = 0;
settings.stealFocusOnLoad = true;
settings.showModeStatus = false;
settings.richHintsForKeystroke = false;
settings.modeAfterYank = 'Normal';

// new mappings
mapkey('p', 'Switch frames', 'Normal.rotateFrame()');
mapkey('gu', '#4Edit current URL with vim editor', function() {
    Front.showEditor(window.location.href, function(data) {
        tabOpenLink(data);
    }, 'url');
});
mapkey('s', '#2Scroll down', 'Normal.scroll("down")', {repeatIgnore: true});
mapkey('w', '#2Scroll up', 'Normal.scroll("up")', {repeatIgnore: true});

// alias current mappings
map('F', 'af');

// unmaps
unmap('C');
unmap('ss');
unmap('k', /(reddit|feedly|mail\.google)\.com/);
unmap('j', /(reddit|feedly|mail\.google)\.com/);
unmap('v', /feedly\.com/);
unmap('p', /reddit\.com/);

// alias current mappings
map('F', 'af');
map('s', 'j');
map('w', 'k');
map(';m', 'sm');

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
    color: #22a21f;
}
.sk_theme .annotation {
    color: #000000;
}

.sk_theme .focused {
    background: #c7c7c7;
};

.sk_hints {
    background: #22a21f !important;
};
`
