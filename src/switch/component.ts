/**
 * @license
 * Copyright 2018 Google Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import {MDCComponent} from '@material/base/component';
import {EventType} from '@material/base/types';
import {ponyfill} from '@material/dom/index';
import {MDCRipple, MDCRippleAdapter, MDCRippleCapableSurface, MDCRippleFoundation} from '@material/ripple/index';
import {MDCSwitchAdapter} from '@material/switch/adapter';
import {MDCSwitchFoundation} from '@material/switch/foundation';

export class MDCSwitch extends MDCComponent<MDCSwitchFoundation> implements MDCRippleCapableSurface {
  static attachTo(root: HTMLElement) {
    return new MDCSwitch(root);
  }

  // Public visibility for this property is required by MDCRippleCapableSurface.
  root_!: Element; // assigned in MDCComponent constructor

  private readonly ripple_ = this.createRipple_();

  destroy() {
    super.destroy();
    this.ripple_.destroy();
  }

  getDefaultFoundation() {
    // DO NOT INLINE this variable. For backward compatibility, foundations take a Partial<MDCFooAdapter>.
    // To ensure we don't accidentally omit any methods, we need a separate, strongly typed adapter variable.
    const adapter: MDCSwitchAdapter = {
      addClass: (className) => this.root_.classList.add(className),
      removeClass: (className) => this.root_.classList.remove(className),
      setNativeControlChecked: (checked) => this.nativeControl_.checked = checked,
      setNativeControlDisabled: (disabled) => this.nativeControl_.disabled = disabled,
    };
    return new MDCSwitchFoundation(adapter);
  }

  get ripple() {
    return this.ripple_;
  }

  get checked() {
    return this.nativeControl_.checked;
  }

  set checked(checked) {
    this.foundation_.setChecked(checked);
    this.foundation_.handleChange(({ target: this.nativeControl_ } as unknown) as Event);
  }

  get disabled() {
    return this.nativeControl_.disabled;
  }

  set disabled(disabled) {
    this.foundation_.setDisabled(disabled);
  }

  private createRipple_(): MDCRipple {
    const {RIPPLE_SURFACE_SELECTOR} = MDCSwitchFoundation.strings;
    const rippleSurface = this.root_.querySelector(RIPPLE_SURFACE_SELECTOR) as HTMLElement;

    // DO NOT INLINE this variable. For backward compatibility, foundations take a Partial<MDCFooAdapter>.
    // To ensure we don't accidentally omit any methods, we need a separate, strongly typed adapter variable.
    const adapter: MDCRippleAdapter = {
      ...MDCRipple.createAdapter(this),
      addClass: (className: string) => rippleSurface.classList.add(className),
      computeBoundingRect: () => rippleSurface.getBoundingClientRect(),
      deregisterInteractionHandler: (evtType: EventType, handler: EventListener) => {
        this.nativeControl_.removeEventListener(evtType, handler);
      },
      isSurfaceActive: () => ponyfill.matches(this.nativeControl_, ':active'),
      isUnbounded: () => true,
      registerInteractionHandler: (evtType: EventType, handler: EventListener) => {
        this.nativeControl_.addEventListener(evtType, handler);
      },
      removeClass: (className: string) => rippleSurface.classList.remove(className),
      updateCssVariable: (varName: string, value: string) => {
        rippleSurface.style.setProperty(varName, value);
      },
    };
    return new MDCRipple(this.root_, new MDCRippleFoundation(adapter));
  }

  private get nativeControl_() {
    const {NATIVE_CONTROL_SELECTOR} = MDCSwitchFoundation.strings;
    return this.root_.querySelector(NATIVE_CONTROL_SELECTOR) as HTMLInputElement;
  }
}