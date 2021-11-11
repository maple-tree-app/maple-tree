import { clickMobileMenu, closeOnUnfocus, doCopyToClipboard }  from './events/index';
import {darkMode} from './theme/index';


export const hooks: any = {};

hooks.darkMode = darkMode;
hooks.clickMobileMenu = clickMobileMenu;
hooks.closeOnUnfocus = closeOnUnfocus;
hooks.doCopyToClipboard = doCopyToClipboard;

