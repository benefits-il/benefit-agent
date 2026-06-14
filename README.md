# benefit-agent

מארז ההפצה של **Benefit**, סוכן הידע האישי של קורס Benefits (יחידת שכבות זיכרון, שיעור 2). הריפו אורז את הסקילים בפורמט התקני של Agent Skills, כך שאפשר להוריד ולהתקין אותם בקלוד.

התלמיד בונה את Benefit כפרויקט (Project) בקלוד עם חיבור Notion (קריאה וכתיבה), מתקין מכאן את ארבעת הסקילים, ומעלה את קובצי הידע. הוא לא בונה אותם.

## מבנה הריפו
```
benefit-agent/
├── index.html                       דף ההורדה (הורדת סקילים וקבצי ידע + הוראות התקנה)
├── skills/                          הסקילים במבנה התקני (תיקייה + SKILL.md)
│   ├── benefit-save-page/SKILL.md       שמירה ויצירת עמוד (בכיתה, מופעל-כפתור)
│   ├── benefit-retrieve/SKILL.md        שליפה לפי-צורך (בכיתה)
│   ├── benefit-studio-consult/SKILL.md  ייעוץ ופירוק לפי STUDIO (בבית)
│   └── benefit-micro-prompt/SKILL.md    בונה פרומפט לפי MICRO (בבית)
├── knowledge/                       קבצי הידע שעולים לפרויקט
│   ├── benefit-agent.md                 הסוכן הבנוי, להדבקה להוראות הפרויקט
│   └── course-structure.md              מבנה-הקורס, קובץ הידע המרכזי
├── dist/                            ZIP מוכן להעלאה ל-claude.ai, אחד לכל סקיל
└── scripts/package-skills.ps1       בונה מחדש את ה-ZIP-ים מתוך skills/
```

## איך מתקינים סקיל בקלוד
כל סקיל ב-`dist/` הוא קובץ ZIP מוכן להעלאה. ה-ZIP מכיל תיקייה עם `SKILL.md` בתוכה, כפי ש-claude.ai דורש.
1. ודאו שהרצת קוד (Code execution) מופעלת בהגדרות, תחת Capabilities או Features.
2. בקלוד, היכנסו ל-Settings, ובמקטע Skills בחרו העלאה (Upload skill).
3. העלו את קובץ ה-ZIP של הסקיל מתוך `dist/`.
4. חזרו על זה לכל אחד מארבעת הסקילים.
5. פתחו את פרויקט Benefit, והסקילים זמינים לשימוש.

חלופה: אפשר ליצור סקיל חדש דרך ה-Skill Creator בקלוד ולהדביק לתוכו את תוכן ה-`SKILL.md`, בלי ZIP.

## קבצי הידע
- העלו את `knowledge/course-structure.md` לפרויקט כקובץ Knowledge.
- הדביקו את התוכן של `knowledge/benefit-agent.md` להוראות הפרויקט (Project instructions).

## בנייה מחדש של ה-ZIP-ים
אחרי עריכת סקיל, הריצו ב-PowerShell:
```
pwsh scripts/package-skills.ps1
```
הסקריפט אורז כל תיקייה תחת `skills/` לקובץ ZIP מקביל ב-`dist/`.

## התקנה ב-Claude Code (לא חובה ללומד)
אפשר להעתיק תיקיית סקיל אל `.claude/skills/` בפרויקט, או אל `~/.claude/skills/` למשתמש, וקלוד יזהה אותה אוטומטית.

## חלוקת כיתה ובית
- **בכיתה:** שמירה ושליפה, שני הכיוונים של המאגר.
- **בבית:** ייעוץ STUDIO ובניית פרומפט MICRO.

---

מקור-האמת לבניית המארז: המפרטים תחת `benefits/course-ops/topics/content-buildout/memory-layers-rebuild/` והגדרת הסוכן `benefits/course-ops/agents/spoke/benefit.md`. נבנה דרך הסקיל Seeker.
