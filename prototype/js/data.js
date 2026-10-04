'use strict';
/* ================= helpers ================= */
const $ = (s, el = document) => el.querySelector(s);
const $$ = (s, el = document) => Array.from(el.querySelectorAll(s));
const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
const uid = () => 'e' + Math.random().toString(36).slice(2, 9);
const pad = n => String(n).padStart(2, '0');
const dayKey = ts => { const d = new Date(ts); return d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()); };
const fromKey = k => { const [y, m, d] = k.split('-').map(Number); return new Date(y, m - 1, d, 12); };
const WD1 = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
const WDF = ['Chủ nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'];
const longDate = d => `${WDF[d.getDay()]}, ${d.getDate()} tháng ${d.getMonth() + 1}`;
const timeStr = ts => { const d = new Date(ts); return pad(d.getHours()) + ':' + pad(d.getMinutes()); };
const fmt1 = n => n.toFixed(1).replace('.', ',');
const getPath = (o, p) => p.split('.').reduce((a, k) => (a == null ? a : a[k]), o);
const setPath = (o, p, v) => { const ks = p.split('.'); const last = ks.pop(); const t = ks.reduce((a, k) => (a[k] == null ? (a[k] = {}) : a[k]), o); t[last] = v; };

/* ================= icons ================= */
const ICONS = {
  home: '<path d="M3.5 11 12 3.5 20.5 11v8.5a1 1 0 0 1-1 1H15v-6H9v6H4.5a1 1 0 0 1-1-1z"/>',
  cal: '<rect x="3.5" y="5" width="17" height="15.5" rx="3.5"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
  chart: '<path d="M4 20h16"/><rect x="6" y="11" width="3" height="6" rx="1"/><rect x="10.5" y="6" width="3" height="11" rx="1"/><rect x="15" y="9" width="3" height="8" rx="1"/>',
  sliders: '<path d="M4 7h8M16 7h4M4 17h4M12 17h8"/><circle cx="14" cy="7" r="2"/><circle cx="10" cy="17" r="2"/>',
  plus: '<path d="M12 5v14M5 12h14"/>',
  back: '<path d="M14.5 5 7.5 12l7 7"/>',
  chev: '<path d="m9.5 5 7 7-7 7"/>',
  chevl: '<path d="M14.5 5 7.5 12l7 7"/>',
  check: '<path d="m5 12.5 4.5 4.5L19 7.5"/>',
  close: '<path d="M6 6l12 12M18 6 6 18"/>',
  audio: '<path d="M4 9.5v5h3.5L12 18.5v-13L7.5 9.5z"/><path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11"/>',
  audiooff: '<path d="M4 9.5v5h3.5L12 18.5v-13L7.5 9.5z"/><path d="m16 9.5 4 5M20 9.5l-4 5"/>',
  leaf: '<path d="M5 19c-.5-8 4-14 14-14 0 9-5 14.5-13 14"/><path d="M5 19c2.5-4.5 5.5-7.5 9-9.5"/>',
  shield: '<path d="M12 3.5 19.5 6v6c0 4.5-3.2 7.4-7.5 8.5C7.7 19.4 4.5 16.5 4.5 12V6z"/><path d="m9 12 2.2 2.2L15.5 10"/>',
  lock: '<rect x="5" y="10.5" width="14" height="10" rx="2.5"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5"/>',
  bell: '<path d="M6 16.5V11a6 6 0 0 1 12 0v5.5l1.5 1.5h-15z"/><path d="M10 20.5a2 2 0 0 0 4 0"/>',
  bellOff: '<path d="M6 16.5V11a6 6 0 0 1 1.5-4M18 11v5.5l1.5 1.5H8"/><path d="M10 20.5a2 2 0 0 0 4 0M4 4l16 16"/>',
  download: '<path d="M12 4v11M7.5 11 12 15.5 16.5 11M5 20h14"/>',
  trash: '<path d="M4.5 7h15M9.5 7V4.5h5V7M6.5 7l.8 12.5h9.4L17.5 7M10 11v5M14 11v5"/>',
  sparkle: '<path d="M11 3.5 12.8 9 18.5 10.8 12.8 12.6 11 18.5 9.2 12.6 3.5 10.8 9.2 9z"/><path d="m18.5 15.5.7 1.8 1.8.7-1.8.7-.7 1.8-.7-1.8-1.8-.7 1.8-.7z"/>',
  wifioff: '<path d="M2.5 9a15 15 0 0 1 5.5-3.2M21.5 9A15 15 0 0 0 12 5.5M5.5 12.8a10 10 0 0 1 3-1.8M18.5 12.8A10 10 0 0 0 15.5 11M8.8 16.5a5 5 0 0 1 6.4 0M12 20h.01M3.5 3.5l17 17"/>',
  alert: '<path d="M12 4 21 19.5H3z"/><path d="M12 10v4.5M12 17.3h.01"/>',
  heart: '<path d="M12 20s-7.5-4.6-7.5-10.2A4.3 4.3 0 0 1 12 7.5a4.3 4.3 0 0 1 7.5 2.3C19.5 15.4 12 20 12 20z"/>',
  phone: '<path d="M5.5 4h3.5l1.8 4.5-2.3 1.5a11 11 0 0 0 5 5l1.5-2.3 4.5 1.8V18a2 2 0 0 1-2 2A15.5 15.5 0 0 1 3.5 6a2 2 0 0 1 2-2z"/>',
  edit: '<path d="M4 20h4L19.5 8.5l-4-4L4 16z"/><path d="m13.5 6.5 4 4"/>',
  refresh: '<path d="M19.5 11.5A7.5 7.5 0 1 0 17.5 17M19.5 5v6.5H13"/>',
  info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5M12 8h.01"/>',
  clock: '<circle cx="12" cy="12" r="8.5"/><path d="M12 7.5V12l3 2"/>',
  sun: '<circle cx="12" cy="12" r="3.8"/><path d="M12 3v2M12 19v2M3 12h2M19 12h2M5.6 5.6 7 7M17 17l1.4 1.4M5.6 18.4 7 17M17 7l1.4-1.4"/>',
  sunset: '<path d="M5 17a7 7 0 0 1 14 0M3 20.5h18M12 6V4M4.5 10 6 11.5M19.5 10 18 11.5"/>',
  moon: '<path d="M19.5 14.5A8 8 0 1 1 9.5 4.5a6.5 6.5 0 0 0 10 10z"/>',
  eye: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="2.8"/>',
  msg: '<path d="M4.5 5.5h15v10h-8l-4.5 3.5v-3.5h-2.5z"/>',
  copy: '<rect x="8.5" y="8.5" width="11" height="11" rx="2.5"/><path d="M15.5 8.5V6.5a2 2 0 0 0-2-2h-7a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h2"/>',
  grid: '<rect x="4" y="4" width="6.5" height="6.5" rx="1.5"/><rect x="13.5" y="4" width="6.5" height="6.5" rx="1.5"/><rect x="4" y="13.5" width="6.5" height="6.5" rx="1.5"/><rect x="13.5" y="13.5" width="6.5" height="6.5" rx="1.5"/>',
  doc: '<path d="M6.5 3.5H14l4 4v13H6.5z"/><path d="M14 3.5v4h4M9 12.5h6M9 16h6"/>',
  scan: '<path d="M4 8V6a2 2 0 0 1 2-2h2M16 4h2a2 2 0 0 1 2 2v2M20 16v2a2 2 0 0 1-2 2h-2M8 20H6a2 2 0 0 1-2-2v-2M9 10v1.5M15 10v1.5M9 15.5c1.8 1.4 4.2 1.4 6 0"/>',
  help: '<circle cx="12" cy="12" r="8.5"/><path d="M9.7 9.5a2.4 2.4 0 1 1 3.4 2.2c-.7.4-1.1.9-1.1 1.8M12 16.5h.01"/>',
  mail: '<rect x="3.5" y="5.5" width="17" height="13" rx="2.5"/><path d="m4 7.5 8 6 8-6"/>',
  repeat: '<path d="M17 4.5 20 7.5l-3 3M4 12v-1.5a3 3 0 0 1 3-3h13M7 19.5l-3-3 3-3M20 12v1.5a3 3 0 0 1-3 3H4"/>',
  wind: '<path d="M3 9h10a2.5 2.5 0 1 0-2.5-2.5M3 15h14a2.5 2.5 0 1 1-2.5 2.5M3 12h7"/>',
  sprout: '<path d="M12 20v-8M12 12c0-4 2.5-6 6.5-6 0 4-2.5 6-6.5 6zM12 15c0-3-2-5-5.5-5 0 3 2 5 5.5 5z"/>',
  compass: '<circle cx="12" cy="12" r="8.5"/><path d="m15.5 8.5-2 5-5 2 2-5z"/>',
  ground: '<path d="M4 18c3-2 5-2 8 0s5 2 8 0M4 13c3-2 5-2 8 0s5 2 8 0M4 8c3-2 5-2 8 0s5 2 8 0"/>',
  reframe: '<path d="M5 8h9a4 4 0 0 1 0 8H8"/><path d="m8 13-3 3 3 3M16 4l3 4-3 4" transform="translate(0 -1)"/>',
  pause: '<rect x="7" y="5.5" width="3.5" height="13" rx="1.2"/><rect x="13.5" y="5.5" width="3.5" height="13" rx="1.2"/>',
  users: '<circle cx="9" cy="8.5" r="3.2"/><path d="M3 19c.5-3.500 3-5 6-5s5.500 1.500 6 5M16 5.500a3 3 0 0 1 0 6M18 14.500c1.700.7 2.700 2 3 4.500"/>'
};
const ic = (n, s = 22, sw = 1.8) => `<svg class="ic" width="${s}" height="${s}" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="${sw}" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">${ICONS[n] || ''}</svg>`;

/* ================= emotions ================= */
const CATS = {
  calm: { vi: 'Bình yên', bg: '#B8E0D1', fg: '#254A4A', tint: '#E3F5EF' },
  positive: { vi: 'Tích cực', bg: '#F7DE63', fg: '#4A4318', tint: '#FFF6C8' },
  low: { vi: 'Trầm lắng', bg: '#AFC3F1', fg: '#263C78', tint: '#E9EFFF' },
  stress: { vi: 'Căng thẳng', bg: '#B9A7E8', fg: '#45306F', tint: '#F0EBFF' },
  high: { vi: 'Cường độ cao', bg: '#E86B83', fg: '#571C2A', tint: '#FBE3E8' },
  none: { vi: '', bg: '#DCE2E8', fg: '#4A5260', tint: '#F0F3F7' }
};
const FACE_COLORS = {
  happy: ['#F3B6C8', '#40283A'], calm: ['#A9DCCB', '#204B4A'], sad: ['#AFC4F4', '#263B72'],
  angry: ['#F08A5D', '#5A271D'], anxious: ['#C5B8EA', '#44316E'], stressed: ['#F3A27D', '#5A2D2A'],
  ashamed: ['#F4CE69', '#574311'], tired: ['#C9D7D2', '#334746'], neutral: ['#DDE2E8', '#43505A']
};
const EMO = {
  calm: { vi: 'Bình yên', face: 'calm', cat: 'calm' },
  happy: { vi: 'Vui', face: 'happy', cat: 'positive' },
  sad: { vi: 'Buồn', face: 'sad', cat: 'low' },
  angry: { vi: 'Tức giận', face: 'angry', cat: 'high' },
  anxious: { vi: 'Lo lắng', face: 'anxious', cat: 'stress' },
  stressed: { vi: 'Căng thẳng', face: 'stressed', cat: 'stress' },
  ashamed: { vi: 'Xấu hổ', face: 'ashamed', cat: 'low' },
  tired: { vi: 'Mệt mỏi', face: 'tired', cat: 'low' },
  confused: { vi: 'Bối rối', face: 'anxious', cat: 'stress' },
  lonely: { vi: 'Cô đơn', face: 'sad', cat: 'low' },
  disappointed: { vi: 'Thất vọng', face: 'sad', cat: 'low' },
  grateful: { vi: 'Biết ơn', face: 'happy', cat: 'positive' },
  relieved: { vi: 'Nhẹ nhõm', face: 'calm', cat: 'calm' },
  hopeful: { vi: 'Hy vọng', face: 'happy', cat: 'positive' },
  irritated: { vi: 'Bực bội', face: 'angry', cat: 'high' },
  numb: { vi: 'Trống rỗng', face: 'tired', cat: 'low' },
  none: { vi: 'Chọn một cảm xúc', face: 'neutral', cat: 'none' }
};
const PRIMARY = ['calm', 'happy', 'sad', 'angry', 'anxious', 'stressed', 'ashamed', 'tired'];
const MORE = ['confused', 'lonely', 'disappointed', 'grateful', 'relieved', 'hopeful', 'irritated', 'numb'];
const INTENSITY = ['Rất thấp', 'Thấp', 'Vừa phải', 'Cao', 'Rất cao'];
const catOf = (emo, n) => { const c = EMO[emo].cat; return (n >= 5 && (c === 'stress' || c === 'low')) ? 'high' : c; };
const TRIG = { work: 'Công việc / học tập', relation: 'Mối quan hệ', family: 'Gia đình', money: 'Tiền bạc', health: 'Sức khỏe', social: 'Tình huống xã hội', uncertainty: 'Sự không chắc chắn', other: 'Khác' };

/* soft blobs + minimal line faces */
function blob(seed, amp, n = 8, r = 43) {
  let s = seed; const rnd = () => { s = (s * 9301 + 49297) % 233280; return s / 233280; };
  const pts = [];
  for (let i = 0; i < n; i++) { const a = (i / n) * Math.PI * 2; const rr = r * (1 - amp + rnd() * amp * 2); pts.push([50 + Math.cos(a) * rr, 50 + Math.sin(a) * rr]); }
  const f = v => v.toFixed(1);
  let d = `M${f(pts[0][0])},${f(pts[0][1])}`;
  for (let i = 0; i < n; i++) {
    const p0 = pts[(i - 1 + n) % n], p1 = pts[i], p2 = pts[(i + 1) % n], p3 = pts[(i + 2) % n];
    d += `C${f(p1[0] + (p2[0] - p0[0]) / 6)},${f(p1[1] + (p2[1] - p0[1]) / 6)} ${f(p2[0] - (p3[0] - p1[0]) / 6)},${f(p2[1] - (p3[1] - p1[1]) / 6)} ${f(p2[0])},${f(p2[1])}`;
  }
  return d + 'Z';
}
const BLOBS = { calm: blob(11, .025), happy: blob(23, .05), sad: blob(37, .07), angry: blob(53, .1), anxious: blob(71, .11), stressed: blob(89, .1), ashamed: blob(101, .07), tired: blob(131, .06), neutral: blob(5, .03) };
const dot = (x, y, r, c) => `<circle cx="${x}" cy="${y}" r="${r}" fill="${c}" stroke="none"/>`;
const FACE = {
  calm: c => `<path d="M33 49q6 6 12 0M55 49q6 6 12 0"/><path d="M42 63q8 5 16 0"/>`,
  happy: c => `<path d="M33 52q6-9 12 0M55 52q6-9 12 0"/><path d="M38 62q12 14 24 0"/>`,
  sad: c => dot(38, 51, 3.2, c) + dot(62, 51, 3.2, c) + `<path d="M31 44l13-4M56 40l13 4"/><path d="M40 68q10-9 20 0"/>`,
  angry: c => dot(39, 53, 3.2, c) + dot(61, 53, 3.2, c) + `<path d="M31 41l13 5M56 46l13-5"/><path d="M41 67h18"/>`,
  anxious: c => dot(38, 51, 3.8, c) + dot(62, 51, 3.8, c) + `<path d="M31 41l13-4M56 37l13 4"/><path d="M40 66q5-5 10 0t10 0"/>`,
  stressed: c => `<path d="M33 46l10 5-10 5M67 46 57 51l10 5"/><path d="M39 67q5.500-5 11 0t11 0"/>`,
  ashamed: c => dot(39, 54, 3.2, c) + dot(61, 54, 3.2, c) + `<ellipse cx="30" cy="61" rx="5" ry="3" fill="${c}" stroke="none" opacity=".28"/><ellipse cx="70" cy="61" rx="5" ry="3" fill="${c}" stroke="none" opacity=".28"/><path d="M44 68q6-3 12 1"/>`,
  neutral: c => dot(38, 52, 3.2, c) + dot(62, 52, 3.2, c) + `<path d="M42 65h16"/>`,
  tired: c => `<path d="M33 50h12M55 50h12"/><path d="M36 56q3 3 6 0M58 56q3 3 6 0"/><path d="M44 67h12"/>`
};
function faceSVG(key, size = 48, o = {}) {
  const e = EMO[key] || EMO.calm; const c = CATS[o.cat || e.cat]; const colors = FACE_COLORS[e.face] || [c.bg, c.fg];
  return `<svg class="face" width="${size}" height="${size}" viewBox="0 0 100 100" aria-hidden="true"><path d="${BLOBS[e.face]}" fill="${colors[0]}"/><g fill="none" stroke="${colors[1]}" stroke-width="3.6" stroke-linecap="round" stroke-linejoin="round">${FACE[e.face](colors[1])}</g></svg>`;
}
const faceOf = (e, size) => faceSVG(e.emotion, size, { cat: catOf(e.emotion, e.intensity) });

/* ================= exercises ================= */
const EXS = {
  grounding: {
    name: 'Neo về hiện tại', sub: '5-4-3-2-1', min: 2, icon: 'ground', desc: 'Kết nối lại với hiện tại.',
    steps: [
      { k: 'sense', n: 5, t: '5 thứ bạn nhìn thấy' }, { k: 'sense', n: 4, t: '4 thứ bạn chạm vào' }, { k: 'sense', n: 3, t: '3 âm thanh bạn nghe' },
      { k: 'sense', n: 2, t: '2 mùi hương bạn ngửi' }, { k: 'sense', n: 1, t: '1 vị bạn nếm' }
    ]
  },
  reframe: {
    name: 'Nhìn lại suy nghĩ', sub: 'Tái cấu trúc suy nghĩ', min: 3, icon: 'reframe', desc: 'Tìm một cách nhìn cân bằng hơn.',
    steps: [
      { k: 'write', t: 'Suy nghĩ đó là gì?', ph: 'Viết vài từ', pre: 'thought' },
      { k: 'write', t: 'Điều gì ủng hộ nó?', ph: 'Điều đã thật sự xảy ra' },
      { k: 'write', t: 'Điều gì chưa ủng hộ nó?', ph: 'Điều cho thấy bức tranh khác' },
      { k: 'write', t: 'Bạn sẽ nói gì với một người bạn?', ph: 'Mình sẽ nói…' },
      { k: 'write', t: 'Một cách nhìn cân bằng hơn?', ph: 'Có thể mình…', pre: 'balanced' }
    ]
  },
  compassion: {
    name: 'Lời dịu dàng', sub: 'Tự thấu cảm', min: 3, icon: 'heart', desc: 'Nói với mình bằng giọng dịu dàng.',
    steps: [
      { k: 'write', t: 'Bạn sẽ nói gì với một người bạn thân?', ph: 'Mình sẽ nói…' },
      { k: 'write', t: 'Nói lại điều đó với chính mình', ph: 'Mình cũng xứng đáng…', mirror: 0 }
    ]
  },
  pause: {
    name: 'Khoảng dừng', sub: 'Trước khi đáp lại', min: 2, icon: 'pause', desc: 'Dừng vài nhịp trước khi đáp lại.',
    steps: [
      { k: 'stop', t: 'Dừng lại' }, { k: 'breath', t: 'Thở chậm ba lần' }, { k: 'name', t: 'Gọi tên cảm xúc' },
      { k: 'write', t: 'Điều gì quan trọng lúc này?', ph: 'Điều mình quan tâm là…', short: true }, { k: 'choose', t: 'Bạn muốn làm gì tiếp?' }
    ]
  }
};
const NEXT_ACTIONS = ['Nói chuyện bình tĩnh', 'Nghỉ 10 phút', 'Viết ra', 'Nhờ ai đó', 'Đi bộ', 'Chưa làm gì'];
const recommend = emo => ({ stressed: 'reframe', anxious: 'grounding', angry: 'pause', sad: 'compassion', ashamed: 'compassion', tired: 'grounding', calm: 'grounding', happy: 'compassion' }[EMO[emo].face] || 'grounding');

/* ================= reflection generator (possibility language, non-diagnostic) ================= */
const SECOND = { calm: 'Thư thái', happy: 'Biết ơn', sad: 'Hụt hẫng', angry: 'Thất vọng', anxious: 'Bất an', stressed: 'Quá tải', ashamed: 'Ngại ngùng', tired: 'Cạn năng lượng' };
const TRIG_TXT = {
  work: 'Áp lực công việc, học tập', relation: 'Khoảng cách trong mối quan hệ', family: 'Kỳ vọng trong gia đình', money: 'Lo toan tiền bạc',
  health: 'Lo ngại về sức khỏe', social: 'Cảm giác bị đánh giá', uncertainty: 'Điều chưa chắc chắn', other: 'Một điều trong ngày'
};
const THOUGHT_D = { stressed: 'Mình phải làm tốt mọi thứ ngay lập tức.', anxious: 'Có điều gì đó sẽ đi sai.', sad: 'Mọi chuyện sẽ không khá hơn.', angry: 'Họ không tôn trọng mình.', ashamed: 'Mình chưa đủ tốt.', tired: 'Mình không còn đủ sức để tiếp tục.', calm: 'Mình đang ổn và muốn ghi nhận điều đó.', happy: 'Khoảnh khắc này thật đáng trân trọng.' };
const QUESTION = {
  stressed: 'Bạn sẽ nói gì với một người bạn ở hoàn cảnh này?', anxious: 'Điều gì đang thật sự xảy ra lúc này?',
  sad: 'Lúc này bạn cần điều gì nhất?', angry: 'Điều gì quan trọng với bạn ở đây?',
  ashamed: 'Có điều gì cho thấy bức tranh khác không?', tired: 'Điều nhỏ nào giúp bạn nghỉ ngơi?',
  calm: 'Điều gì giúp bạn thấy như vậy?', happy: 'Điều gì góp phần tạo nên khoảnh khắc này?'
};
const BALANCED = {
  stressed: 'Đây chỉ là một khoảnh khắc, không phải toàn bộ mình.', anxious: 'Mình có thể lo và vẫn làm từng bước.',
  sad: 'Cảm giác này thật, và sẽ thay đổi.', angry: 'Mình có thể giận và vẫn chọn cách đáp lại.',
  ashamed: 'Một sai sót không định nghĩa mình.', tired: 'Nghỉ ngơi cũng là một cách tiếp tục.',
  calm: 'Mình có thể nhớ lại khoảnh khắc này.', happy: 'Mình có thể giữ cảm giác này làm điểm tựa.'
};
function genReflection(d) {
  const b = EMO[d.emotion].face; const pos = (b === 'calm' || b === 'happy');
  return {
    feelings: [EMO[d.emotion].vi, SECOND[b]], trigger: TRIG_TXT[d.trigger || 'other'],
    thought: (d.thought && d.thought.trim()) || THOUGHT_D[b], question: QUESTION[b], balanced: BALANCED[b], pos
  };
}

/* ================= sample data ================= */
function blankDraft() { return { emotion: null, intensity: 3, situation: '', trigger: null, repeat: false, thought: '', response: '' }; }
function mk(off, h, mi, o) {
  const d = new Date(); d.setHours(h, mi, 0, 0); d.setDate(d.getDate() - off);
  const e = Object.assign({ id: uid(), ts: d.getTime(), intensity: 3, trigger: 'other', situation: '', thought: '', response: '', repeat: false, ai: null, edited: false, ex: null }, o);
  e.ai = genReflection(e);
  return e;
}
function sampleEntries() {
  const L = [];
  L.push(mk(1, 18, 40, { emotion: 'stressed', intensity: 4, trigger: 'work', situation: 'Nhận được phản hồi bất ngờ từ sếp trong buổi họp.', thought: 'Mình làm chưa đủ tốt.', response: 'Mình im lặng và tránh nói chuyện với mọi người.', ex: { id: 'reframe', done: true, after: { emotion: 'stressed', intensity: 3 } } }));
  L.push(mk(2, 8, 15, { emotion: 'anxious', intensity: 4, trigger: 'work', situation: 'Deadline dự án bị đẩy lên sớm hơn dự kiến.', thought: 'Mình sẽ không kịp.', response: 'Mình làm việc liên tục và bỏ bữa trưa.', ex: { id: 'grounding', done: true, after: { emotion: 'anxious', intensity: 3 } } }));
  L.push(mk(2, 21, 30, { emotion: 'tired', intensity: 3, trigger: 'other', situation: 'Cuối ngày nhưng đầu óc vẫn chưa nghỉ.' }));
  L.push(mk(3, 19, 5, { emotion: 'stressed', intensity: 3, trigger: 'work', situation: 'Nhiều việc chồng lên nhau vào cuối tuần.', thought: 'Mình phải xong hết trước khi nghỉ.', ex: { id: 'pause', done: true, after: { emotion: 'calm', intensity: 2 } } }));
  L.push(mk(5, 20, 10, { emotion: 'calm', intensity: 2, trigger: 'social', situation: 'Buổi cà phê nhẹ nhàng với một người bạn.' }));
  const em = ['stressed', 'happy', 'sad', 'anxious', 'calm', 'tired', 'ashamed', 'angry', 'stressed', 'calm'];
  const tr = ['work', 'social', 'relation', 'work', 'family', 'health', 'work', 'relation', 'money', 'other'];
  const sit = ['Một buổi họp kéo dài hơn dự kiến.', 'Được bạn bè rủ đi ăn tối.', 'Tin nhắn chưa được trả lời suốt một ngày.', 'Bài thuyết trình sắp đến.', 'Cuộc gọi dài với gia đình.', 'Ngủ không ngon vài đêm liền.', 'Gửi nhầm một email quan trọng.', 'Một cuộc tranh luận nhỏ với đồng nghiệp.', 'Hóa đơn tháng này cao hơn dự tính.', 'Buổi sáng yên tĩnh trước giờ làm.'];
  for (let d = 6, i = 0; d <= 58; d++) {
    if (d % 4 === 0 || d % 5 === 0) continue;
    const k = (d * 3 + i) % 10; const it = 1 + ((d * 7 + k) % 5);
    const o = { emotion: em[k], intensity: it, trigger: tr[k], situation: sit[k] };
    if (i % 3 === 0) { const xid = recommend(o.emotion); o.ex = { id: xid, done: true, after: { emotion: o.emotion, intensity: Math.max(1, it - 1) } }; }
    L.push(mk(d, 8 + (d % 12), (d * 11) % 60, o)); i++;
  }
  return L;
}

/* ================= stats ================= */
function byDay(entries) { const m = {}; entries.forEach(e => { (m[dayKey(e.ts)] = m[dayKey(e.ts)] || []).push(e); }); Object.values(m).forEach(a => a.sort((x, y) => x.ts - y.ts)); return m; }
function lastDays(n) { const a = []; for (let i = n - 1; i >= 0; i--) { const d = new Date(); d.setHours(12, 0, 0, 0); d.setDate(d.getDate() - i); a.push(d); } return a; }
function streakOf(m) { const d = new Date(); d.setHours(12, 0, 0, 0); let n = 0; if (!m[dayKey(d)]) d.setDate(d.getDate() - 1); while (m[dayKey(d)]) { n++; d.setDate(d.getDate() - 1); } return n; }
function longestOf(m) { const ks = Object.keys(m).sort(); let best = 0, cur = 0, prev = null; ks.forEach(k => { const d = fromKey(k); if (prev && Math.round((d - prev) / 864e5) === 1) cur++; else cur = 1; best = Math.max(best, cur); prev = d; }); return best; }
function mode(arr) { const c = {}; arr.forEach(x => { if (x) c[x] = (c[x] || 0) + 1; }); const k = Object.keys(c).sort((a, b) => c[b] - c[a])[0]; return k ? { k, n: c[k] } : null; }
function weekStats(entries) {
  const days = lastDays(7); const start = days[0].getTime() - 12 * 36e5; const w = entries.filter(e => e.ts >= start);
  const m = byDay(w); const withEx = w.filter(e => e.ex && e.ex.done); const ba = withEx.filter(e => e.ex.after);
  const avg = a => a.length ? a.reduce((x, y) => x + y, 0) / a.length : 0;
  const te = mode(w.map(e => e.emotion)); const tt = mode(w.map(e => e.trigger));
  let tte = null; if (tt) tte = mode(w.filter(e => e.trigger === tt.k).map(e => e.emotion));
  return {
    w, days: Object.keys(m).length, topEmo: te, topTrig: tt, topEmoInTrig: tte, avgInt: avg(w.map(e => e.intensity)),
    exN: withEx.length, before: ba.length ? avg(ba.map(e => e.intensity)) : null, after: ba.length ? avg(ba.map(e => e.ex.after.intensity)) : null, baN: ba.length
  };
}
const BADGES = [
  { id: 'first', name: 'Lần phản tư đầu tiên', cond: 'Check-in lần đầu', icon: 'leaf', c: '#B9D8BE', f: '#2D5A3A', msg: 'Bạn đã lắng nghe chính mình.' },
  { id: 'three', name: 'Ba ngày hiện diện', cond: 'Check-in 3 ngày liên tiếp', icon: 'sprout', c: '#C3D6E8', f: '#33526F', msg: 'Ba ngày liên tiếp có mặt.' },
  { id: 'week', name: 'Một tuần nhận biết', cond: 'Check-in 7 ngày liên tiếp', icon: 'sun', c: '#F0D49B', f: '#765012', msg: 'Cả tuần bạn đều có mặt.' },
  { id: 'tool', name: 'Thử công cụ mới', cond: 'Làm bài tập đầu tiên', icon: 'compass', c: '#D3CBE6', f: '#54468A', msg: 'Bạn đã thử một cách chăm sóc mới.' }
];
function badgeState(id, entries) {
  const m = byDay(entries); const best = longestOf(m);
  if (id === 'first') return { on: entries.length >= 1, cur: Math.min(entries.length, 1), max: 1 };
  if (id === 'three') return { on: best >= 3, cur: Math.min(best, 3), max: 3 };
  if (id === 'week') return { on: best >= 7, cur: Math.min(best, 7), max: 7 };
  const n = entries.filter(e => e.ex && e.ex.done).length; return { on: n >= 1, cur: Math.min(n, 1), max: 1 };
}

/* ================= safety keyword demo ================= */
const strip = s => String(s || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/đ/g, 'd').replace(/Đ/g, 'd').toLowerCase();
const SAFETY_RE = /tu tu|tu sat|muon chet|khong muon song|khong con muon song|tu lam hai|tu hai ban than|lam hai ban than|ket thuc cuoc doi|ket thuc cuoc song|giet (nguoi|no|anh ay|co ay|ho)\b|lam hai nguoi khac|hai nguoi khac/;
const safetyHit = (...t) => t.some(x => SAFETY_RE.test(strip(x)));
