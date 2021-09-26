import { clickMobileMenu, closeOnUnfocus, doCopyToClipboard }  from './events';
import {darkMode} from './theme';


const hooks = {};

hooks.darkMode = darkMode;
hooks.clickMobileMenu = clickMobileMenu;
hooks.closeOnUnfocus = closeOnUnfocus;
hooks.doCopyToClipboard = doCopyToClipboard;

export default hooks;