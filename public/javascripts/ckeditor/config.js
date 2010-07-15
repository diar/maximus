/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
    // Define changes to default configuration here. For example:
    config.language = 'fr';
    config.uiColor = '#72ADC0';
    config.toolbar_Full =
    [
    ['Source','-','Copy','Paste','-','Undo','Redo'],
    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote','CreateDiv'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    '/',
    ['Styles','Format','Font','FontSize'],
    ['TextColor','BGColor'],
    ['Maximize', 'ShowBlocks','-','Link','Unlink']
    ];
    config.toolbar = 'Full';
};
