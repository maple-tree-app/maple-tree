import { clickMobileMenu }  from './events';
import {darkMode, autoThemeSetter} from './themes';


const hooks = {};

hooks.darkMode = darkMode;
hooks.autoThemeSetter = autoThemeSetter;
hooks.clickMobileMenu = clickMobileMenu;

export default hooks;