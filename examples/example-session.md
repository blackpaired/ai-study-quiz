# Example session

A shortened example of a real-style quiz session with `/study-quiz`. The material is a set of lecture notes on the nerves of the upper limb. *User* is the student, *AI* is the agent running the skill.

---

**User:** `/study-quiz ~/Documents/Anatomy/Upper-limb/`

**AI:** I've read *Upper limb – muscles and nerves* (24 pages; topics: brachial plexus, axillary nerve, musculocutaneous nerve, radial nerve, median nerve, ulnar nerve, hand muscles). We'll start with the arm. Say *stop*, *hint*, *skip*, *easier*, *harder* or *status* at any time.

**Question 1:** Which muscles lie in the anterior compartment of the arm, and which nerve supplies them? Also explain *why* this nerve.

---

**User:** biceps long and short head, brachialis, coracobrachialis, musculocutaneous nerve

**AI:** **Partly right**

**What was right:** all three muscles and the nerve.

**What was missing:** the *why* – and that's exactly what an examiner asks next.

Let's try it with a small push: **What do these three muscles have in common, and what does that have to do with one nerve supplying all of them?**

---

**User:** they all flex the elbow because the nerve runs in front

**AI:** **Almost – but two things are off.**

1. **Coracobrachialis doesn't flex the elbow.** It runs from the coracoid process to the *humerus* and never crosses the elbow. Your notes list only *anteversion* (flexion at the shoulder).
2. **Cause and effect are reversed.** The muscles don't flex *because* the nerve runs in front. It's the other way round: the three muscles share **one fascial compartment** (the flexor compartment), and the core rule in your notes (p. 2) is **one compartment = one nerve**.

Think of the compartment as a shared flat: everyone living there gets their mail from the same postman.

**Question:** One of the three muscles can be supplied by a **second** nerve as well – a classic exam question. Which muscle, which nerve, and why that nerve?

---

**User:** hint

**AI:** **Hint 1:** Think about which nerve runs along the *lateral* side of the distal arm, right next to one of the three muscles.

---

**User:** radial nerve, the brachialis

**AI:** **Correct.** The lateral part of the **brachialis** is *inconstantly* also supplied by the **radial nerve** (your notes, p. 6).

And the why, as you would say it in the exam:
> "The lateral part of the brachialis borders the extensor compartment, where the radial nerve runs between brachialis and brachioradialis. Lying at that border, it can be supplied by both nerves."

Short version: **a muscle at the border of two compartments can get both nerves.** Remember that principle – it comes back several times.

*I'll ask the brachialis again later, phrased differently.*

**Question (same principle, lower limb):** On the thigh, one muscle lies exactly at the border between the anterior and the medial compartment and is supplied twice. Which muscle, and which two nerves?

---

*… the session continues topic by topic until the user says "stop" …*

---

**User:** stop

**AI:** Here's your summary:

- **Sits well:** muscle–nerve assignments of the arm, rotator cuff (SITS), the "one compartment = one nerve" rule.
- **Still shaky:**
  - Functions: which muscle crosses which joint (coracobrachialis, p. 6)
  - Saying the *why* out loud as a full sentence
  - Double innervation of pectineus (p. 14)
- **Tips for next time:** for every muscle, name the joints it crosses before naming its function. Practise answering with "Because …, it is supplied by …".

I've written `Upper-limb_Quiz-Log.md` next to your notes. Next time we'll start with the open points.

---

## The log file it writes

```markdown
# Quiz log: Upper limb – muscles and nerves

Language: English

## Open weak spots (ask these first next time)
- [ ] Coracobrachialis – named as an elbow flexor; it only crosses the shoulder (notes p. 6)
- [ ] Pectineus – double innervation not known (notes p. 14)

## Sits
- [x] Anterior compartment of the arm – muscles + nerve (2026-10-25)
- [x] Brachialis double innervation (2026-10-25, second attempt)

## Sessions
### 2026-10-25 – 9 topics, 5 correct / 3 partly / 1 wrong
- Anterior compartment: muscles right, why missing at first
- Brachialis: correct after one hint
```
