import { clickMobileMenu, closeOnUnfocus, doCopyToClipboard }  from './events/index';
import {darkMode} from './theme/index';


const hooks: any = {};

hooks.darkMode = darkMode;
hooks.clickMobileMenu = clickMobileMenu;
hooks.closeOnUnfocus = closeOnUnfocus;
hooks.doCopyToClipboard = doCopyToClipboard;

export default hooks;
