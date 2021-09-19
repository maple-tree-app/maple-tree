import { clickMobileMenu }  from './events';
import {darkMode, autoThemeSetter} from './theme';


const hooks = {};

hooks.darkMode = darkMode;
hooks.autoThemeSetter = autoThemeSetter;
hooks.clickMobileMenu = clickMobileMenu;

export default hooks;